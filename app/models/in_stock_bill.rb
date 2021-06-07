#coding: utf-8
#实际未提货物清单
class InStockBill < ActiveRecord::Base
  attr_accessible :bill_date, :note, :org_id,:op_org_id, :state, :user_id
  validates :bill_date,:org_id,:op_org_id,:user_id,:state,:presence => true
  belongs_to :org
  belongs_to :user
  belongs_to :op_org,:class_name => "Org"
  has_many :in_stock_bill_lines,:dependent => :destroy
  has_many :carrying_bills,:through => :in_stock_bill_lines

  default_value_for :state,"billed"
  default_value_for :bill_date do
    Date.today
  end
  #定义状态机
  state_machine :initial => :billed do
    event :process do
      transition :billed =>:confirmed
    end
  end
  def bills_count
    carrying_bills.count
  end
  def sum_goods_fee
    carrying_bills.sum(:goods_fee)
  end
  def sum_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH ).sum(:carrying_fee)
  end
  def sum_from_short_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH ).sum(:from_short_carrying_fee)
  end
  def sum_to_short_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH ).sum(:to_short_carrying_fee)
  end
  def sum_insured_fee_th
    carrying_bills.where(:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH ).sum(:insured_fee)
  end
  def sum_manage_fee_th
    carrying_bills.where(:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH ).sum(:manage_fee)
  end
end
