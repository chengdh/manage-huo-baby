#coding: utf-8
#settlement base class
class BaseSettlement < ActiveRecord::Base
  self.table_name = "settlements"
  belongs_to :user
  #FIXME rails3.1 BUG #6978 如果对象是new_record,在执行association finder和where/sum等函数时,会产生错误的sql语句
  has_many :carrying_bills,:order => "goods_no ASC",:conditions => "settlement_id IS NOT NULL",:foreign_key => "settlement_id"

  belongs_to :org
  validates_presence_of :org_id
  #定义状态机
  state_machine :initial => :billed do
    after_transition :on => :process,:billed => :settlemented do |settlement,transition|
      settlement.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:settlemented,:settlemented => :confirmed
    end

    #直接返款确认,中转部门使用
    #    event :direct_refunded_confirmed do
    #      transition :settlemented =>:refunded_confirmed
    #    end
    #    after_transition :on => :direct_refunded_confirmed do |settlement,transition|
    #      settlement.carrying_bills.each {|bill| bill.direct_refunded_confirmed}
    #    end
    #财务收款确认
    event :confirm do
      transition :settlemented =>:confirmed
    end

  end

  default_value_for :bill_date do
    Date.today
  end
  #结算员
  def user_name
    self.user.try(:username)
  end

  #组织机构
  def org_name
    self.org.name
  end
  #提付运费合计,含提付保价费
  def sum_carrying_fee_th
    self.carrying_bills.sum(:carrying_fee,:conditions => {:pay_type => CarryingBill::PAY_TYPE_TH})
  end
  #提付运费合计,含提付保价费
  def sum_manage_fee_th
    self.carrying_bills.sum(:manage_fee,:conditions => {:pay_type => CarryingBill::PAY_TYPE_TH})
  end

  def sum_insured_fee_th
    self.carrying_bills.sum(:insured_fee,:conditions => {:pay_type => CarryingBill::PAY_TYPE_TH})
  end

  def sum_carrying_fee_th_total
    sum_carrying_fee_th  +  sum_manage_fee_th + sum_from_short_carrying_fee_th + sum_to_short_carrying_fee_th + sum_insured_fee_th
  end
  def sum_transit_hand_fee
    self.carrying_bills.sum(:transit_hand_fee)
  end
  def sum_transit_carrying_fee
    self.carrying_bills.sum(:transit_carrying_fee)
  end
  def sum_goods_fee
    carrying_bills.sum(:goods_fee) - sum_goods_fee_qr_pay
  end

  def qy_pay_from_customer_ids
    customer_ids = carrying_bills.pluck(:from_customer_id).compact
    customer_ids.uniq!
    #筛选出二维码支付客户
    qr_customer_ids = Vip.where(:id => customer_ids,:is_qrcode_pay => true).pluck(:id)
  end

  def sum_goods_fee_qr_pay
    qr_customer_ids = qy_pay_from_customer_ids()
    carrying_bills.where(:from_customer_id => qr_customer_ids).sum(:goods_fee)
  end

  def sum_k_hand_fee_qr_pay
    qr_customer_ids = qy_pay_from_customer_ids()
    carrying_bills.where(:from_customer_id => qr_customer_ids).sum(:k_hand_fee)
  end

  def sum_from_short_carrying_fee_th
    self.carrying_bills.sum(:from_short_carrying_fee,:conditions => {:pay_type => CarryingBill::PAY_TYPE_TH})
  end
  def sum_to_short_carrying_fee_th
    self.carrying_bills.sum(:to_short_carrying_fee,:conditions => {:pay_type => CarryingBill::PAY_TYPE_TH})
  end


  def sum_th_amount
    self.sum_goods_fee + self.sum_carrying_fee_th_total - self.sum_transit_hand_fee - self.sum_transit_carrying_fee + sum_k_hand_fee_qr_pay
  end

  #导出到csv
  def to_csv
    ret = ["结算员:",self.user_name,"结算单位:",self.org_name,"结算日期:",self.bill_date].export_line_csv(true)
    ret = ret + ["合计运费:",self.sum_carrying_fee_th_total,"代收货款:",self.sum_goods_fee,"合计:",self.sum_fee].export_line_csv
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,Settlement.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  private
  def self.carrying_bill_export_options
    {
      :only => [],
      :methods => [
        :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
        :to_customer_name,:to_customer_phone,:to_customer_mobile,
        :pay_type_des,
        :carrying_fee_th,:goods_fee,:insured_fee,
        :note,:human_state_name
      ]}
  end
end
