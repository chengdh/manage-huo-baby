#coding: utf-8
class FromShortFeeInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :audit_user,:class_name => "User`"
  belongs_to :from_org,:class_name => "Org"

  #核销部门
  belongs_to :to_org,:class_name => "Org"
  has_many :from_short_fee_lines,:dependent => :destroy
  has_many :carrying_bills,:through => :from_short_fee_lines
  validates_presence_of :from_org_id,:to_org_id,:bill_date

  #定义状态机
  state_machine :initial => :draft do
    after_transition do |info,transition|
      #更新核销时间
      info.update_attributes(:audit_date => DateTime.now)
    end
    event :pass do
      transition :draft => :passed
    end

    event :reject do
      transition :draft => :rejected
    end

  end

  #缺省值设定应定义到state_machine之后
  default_value_for :bill_date do
    Date.today
  end
  #报销金额合
  def sum_from_short_carrying_fee
    sum_from = self.carrying_bills.sum(:from_short_carrying_fee)
  end

  #已提货的报销金额合
  def sum_from_short_carrying_fee_for_deliveried
    sum_from = self.carrying_bills.search(:deliver_info_id_is_not_null => 1).sum(:from_short_carrying_fee)
  end
end
