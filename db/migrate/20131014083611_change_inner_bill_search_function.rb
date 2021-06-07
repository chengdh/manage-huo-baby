#coding: utf-8
#修改中转票,已发货票据统计
class ChangeInnerBillSearchFunction < ActiveRecord::Migration
  def up
    group_name= '内部中转业务'
    subject_title = "已发货票据统计"
    default_action = 'simple_search_carrying_bills_path(:rpt_type => "rpt_inner_bill_sended",:bill_types =>["InnerTransitBill","HandInnerTransitBill"],:show_fields => ".manage_fee,.from_short_carrying_fee,.to_short_carrying_fee,.carrying_fee_1st,.carrying_fee_2st","search[state_ne]" => "billed",:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc" )'
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => default_action) if sf
  end

  def down
  end
end
