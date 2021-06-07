#coding: utf-8
#月结付客户收款登记
class CustomerPaymentInfo < ActiveRecord::Base
  CUSTOMER_PAY_TYPES_FOR_SELECT = {'transfer' => "转账",'cash' => "现金",'wechat' => "微信",'alipay' => "支付宝","bank_card" => "银行卡","other" => "其他"}
  belongs_to :user
  belongs_to :confirm_user,:class_name => "User"
  belongs_to :from_org,:class_name => "Org"
  validates :bill_date,:customer_name,:pay_type,:from_org_id,:presence => true
  has_many :customer_payment_info_lines,:dependent => :destroy
  has_many :carrying_bills,:through => :customer_payment_info_lines

  state_machine :initial => :draft do
    after_transition :draft => :customer_paid do |info,transition|
      #更新核销时间
      info.update_attributes(:confirm_datetime => Time.now)
      info.carrying_bills.each do |bill|
        bill.customer_payment_month_and_re_additional_state!
      end
    end
    event :customer_payment_month_and_re do
      transition :draft => :customer_paid
    end
    event :confirm do
      transition :customer_paid => :confirmed
    end
  end

  #缺省值设定应定义到state_machine之后
  default_value_for :bill_date do
    Date.today
  end
  def pay_type_des
    CUSTOMER_PAY_TYPES_FOR_SELECT[pay_type]
  end

  #合计运费
  def sum_carrying_fee
    sum_fee = carrying_bills.sum(:carrying_fee)
  end
  #合计发货短途
  def sum_from_short_carrying_fee
    sum_fee = carrying_bills.sum(:from_short_carrying_fee)
  end
  #合计到货短途
  def sum_to_short_carrying_fee
    sum_fee = carrying_bills.sum(:to_short_carrying_fee)
  end
  #合计保险费
  def sum_insured_fee
    sum_fee = carrying_bills.sum(:insured_fee)
  end

  def sum_fee
    sum_fee = carrying_bills.sum("carrying_fee + from_short_carrying_fee + to_short_carrying_fee + insured_fee")
  end
end
