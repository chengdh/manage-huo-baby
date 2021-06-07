# -*- encoding : utf-8 -*-
class PaymentList < ActiveRecord::Base
  belongs_to :bank
  belongs_to :org

  #FIXME rails3.1 BUG #6978 如果对象是new_record,在执行association finder和where/sum等函数时,会产生错误的sql语句
  has_many :carrying_bills,:order => "carrying_bills.to_org_id,carrying_bills.bill_date,carrying_bills.from_org_id,carrying_bills.goods_no ASC",:conditions => "payment_list_id IS NOT NULL"

  scope :by_types,lambda {|type_str| where(:type => type_str.split(" "))}

  search_method :by_types

  belongs_to :user

  default_value_for :bill_date do
    Date.today
  end
  #导出到csv
  def to_csv
    ret_array = ["分理处/分公司:",self.org.name,"清单日期:",self.bill_date,"结算员:",self.user.try(:username)]
    #如果是转账清单,则需要显示银行
    #ret_array = ret_array + ["银行:",self.bank.try(:name)] if self.type == "TransferPaymentList"
    ret = ret_array.export_line_csv(true)
    ret = ret + ["备注:",self.note].export_line_csv
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,self.class.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  #运费合计
  def sum_goods_fee
    self.carrying_bills.sum(:goods_fee)
  end
  #扣手续费
  def sum_k_hand_fee
    self.carrying_bills.sum(:k_hand_fee)
  end
  #扣运费
  def sum_k_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee)
  end
  #扣保险费
  def sum_k_insured_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:insured_fee)
  end
  #扣发货短途
  def sum_k_from_short_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:from_short_carrying_fee)
  end
  #扣到货短途
  def sum_k_to_short_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:to_short_carrying_fee)
  end

  #应付合计
  def sum_act_pay_fee
    sum_goods_fee - sum_k_hand_fee - sum_k_carrying_fee - sum_k_insured_fee - sum_k_from_short_carrying_fee - sum_k_to_short_carrying_fee
  end
  def self.carrying_bill_export_options
    {
        :only => [],
        :methods => [
          :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :pay_type_des,
          :k_carrying_fee,:k_hand_fee,:goods_fee,:act_pay_fee,
          :note,:human_state_name
      ]}
  end
end
