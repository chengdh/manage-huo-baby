#coding: utf-8
#同城快运业务-已发票据统计
class AddRptLocalTownBillSendedFunction < ActiveRecord::Migration
  def up
    group_name= '同城快运业务'
    subject_title = "同城快运-已发货票据统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(' + 
      ':rpt_type => "rpt_local_town_bill_sended",'+
      ':bill_types =>["LocalTownBill","HandLocalTownBill"],'+
      '"search[state_ne]" => "billed",'+
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc" )',
      :subject => subject,
      :function => {
        :rpt_local_town_bill_sended =>{:title =>"同城快运-已发货票据统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
