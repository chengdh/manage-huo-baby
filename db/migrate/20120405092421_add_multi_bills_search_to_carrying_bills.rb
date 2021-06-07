#coding: utf-8
#添加多运单查询功能
class AddMultiBillsSearchToCarryingBills < ActiveRecord::Migration
  def self.up
    subject_title = "多运单查询"
    group_name = "查询统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'multi_bills_search_carrying_bills_path',
      :subject => subject,
      :function => {
        :multi_bills_search =>{:title =>"多运单查询"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def self.down
    sf = SystemFunction.find_by_subject_title('多运单查询')
    sf.destroy if sf
  end
end
