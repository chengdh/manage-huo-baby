#coding: utf-8
#欠款提货表
class DebtBill < ActiveRecord::Base
  attr_accessible :bill_date, :note, :op_org_id,:op_org, :org_id,:org, :state, :user_id
  validates :bill_date,:org_id,:op_org_id,:state, :presence => true
  belongs_to :org
  belongs_to :op_org,:class_name => "Org"
  belongs_to :user
  has_many :debt_bill_lines,:dependent => :destroy
  has_many :carrying_bills,:through => :debt_bill_lines

  #默认处理昨天数据
  default_value_for :bill_date do
    1.days.ago.to_date
  end
  default_value_for :state,"billed"
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
  #合计罚金
  #罚金 = (货款 + 运费) * 比例
  def sum_fine
    (sum_goods_fee + sum_carrying_fee_th + sum_insured_fee_th + sum_manage_fee_th) * IlConfig.debt_rate.to_d
  end
  #创建各个分理处/分公司的欠款提货清单
  def self.create_yesterday_debt_bills
    bill_date = 1.days.ago.to_date.strftime("%Y-%m-%d")
    #默认处理单位为总部
    op_org = Org.find_by_is_summary_and_is_active(true,true)
    Org.where(:is_active => true,:is_visible => true,:is_yard => false,:is_summary => false).each do |org|
      debt_bills = CarryingBill.debt_bills(org.id,bill_date)
      if debt_bills.present?
        debt_bill = DebtBill.new(:org => org,:bill_date => bill_date,:op_org => op_org)
        debt_bills.each {|b| debt_bill.debt_bill_lines.build(:carrying_bill => b)}
        debt_bill.process
        debt_bill.save!
      end
    end
  end
end
