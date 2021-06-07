#coding: utf-8
#添加外部中转-已发货票据统计报表
class AddRptOutterTransitBillSended < ActiveRecord::Migration
  def up
    group_name= '外部中转业务'
    subject_title = "外部中转-已发货票据统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(' + 
      ':rpt_type => "rpt_outter_transit_bill_sended",'+
      ':bill_types =>["TransitBill","HandTransitBill"],'+
      '"search[state_ne]" => "billed",'+
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc" )',
      :subject => subject,
      :function => {
        :rpt_outter_transit_bill_sended =>{:title =>"外部中转-已发货票据统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
