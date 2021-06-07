#coding: utf-8
#添加按照客户编号查询运单功能
class AddCustomerCodeSearchFunction < ActiveRecord::Migration
  def self.up
    subject_title = "运单查询-按客户编号"
    group_name = "查询统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'customer_code_search_carrying_bills_path',
      :subject => subject,
      :function => {
        :customer_code_search =>{:title =>"运单查询-按照客户编号"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def self.down
    sf = SystemFunction.find_by_subject_title('运单查询-按客户编号')
    sf.destroy if sf
  end
end
