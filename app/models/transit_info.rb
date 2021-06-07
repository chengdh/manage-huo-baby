# -*- encoding : utf-8 -*-
#货物中转资料
class TransitInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  belongs_to :transit_company  #中转公司
  has_many :carrying_bills
  validates_presence_of :org_id

  accepts_nested_attributes_for :transit_company

  #定义状态机
  state_machine :initial => :billed do
    after_transition do |transit_info,transition|
      transit_info.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:transited
    end
  end
  default_value_for :bill_date do
    Date.today
  end
end

