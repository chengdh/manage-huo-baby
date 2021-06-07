#coding: utf-8
class BaseDistributionList < ActiveRecord::Base
  self.table_name = "distribution_lists"
  belongs_to :user
  has_many :carrying_bills,:foreign_key => "distribution_list_id",:order => "goods_no ASC"

  belongs_to :org
  validates_presence_of :org_id,:bill_date
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |distribution_list,transition|
      distribution_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:distributed
    end
  end

  default_value_for :bill_date do
    Date.today
  end
  #导出到csv
  def to_csv
    ret = ["分货日期:",self.bill_date,"机构:",self.org.name].export_line_csv(true)
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,LoadList.carrying_bill_export_options,false)
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
          :carrying_fee,:goods_fee,
          :note,:human_state_name
      ]}
  end
end
