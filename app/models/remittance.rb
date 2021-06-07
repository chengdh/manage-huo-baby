# -*- encoding : utf-8 -*-
class Remittance < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :user
  belongs_to :validate_user,:class_name => "User"
  belongs_to :refound,:class_name => "BaseRefund"
  validates_presence_of :from_org_id,:to_org_id,:refound_id
  validates_numericality_of :should_fee,:inner_transit_refund_should_fee,:act_fee,:pos_fee,:quick_fee,:other_fee
  #定义状态机
  #草稿 -- 已汇款
  state_machine :initial => :draft do
    event :process do
      transition :draft =>:complete,:complete => :validated
    end
  end

  default_value_for :bill_date do
    Date.today
  end

  def total_fee
    act_fee + pos_fee + quick_fee + other_fee
  end
  def diff_fee
    sum_should_fee - total_fee
  end
  #差额
  def rest_fee
    should_fee - validate_fee
  end
  #应付合计
  def sum_should_fee
    should_fee + inner_transit_refund_should_fee
  end
end
