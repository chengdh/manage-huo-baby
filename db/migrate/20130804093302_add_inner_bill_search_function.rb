#coding: utf-8
#中转票据统计查询
class AddInnerBillSearchFunction < ActiveRecord::Migration
  def up
    group_name= '内部中转业务'
    subject_title = "已发货票据统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_inner_bill_sended",:bill_types =>["InnerTransitBill","HandInnerTransitBill"],"search[state_ne]" => "billed",:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc" )',
      :subject => subject,
      :function => {
        :rpt_inner_bill_sended =>{:title =>"已发货票据统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
