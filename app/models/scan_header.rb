#coding: utf-8
class ScanHeader < ActiveRecord::Base
  belongs_to :user
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  has_many :scan_lines
  has_many :carrying_bills,:through => :scan_lines,:uniq => true
  accepts_nested_attributes_for :scan_lines,:carrying_bills
  default_value_for :bill_date do
    Date.today
  end

  #创建并执行操作
  def self.create_and_process(attr_vals)
    sh = self.new(attr_vals)
    sh.save!
    sh.process
    sh
  end
end
