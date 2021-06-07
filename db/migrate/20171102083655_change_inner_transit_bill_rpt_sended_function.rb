#coding: utf-8
class ChangeInnerTransitBillRptSendedFunction < ActiveRecord::Migration
  def up
    subject_title = "已发货票据统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    default_action = 'simple_search_carrying_bills_path(:rpt_type => "rpt_inner_bill_sended",' +
      ':bill_types =>["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"],"search[state_ne]" => "billed",' +
      ':show_fields =>".manage_fee,.carrying_fee_1st,.carrying_fee_2st,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee",' + 
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc" )'
    sf.update_attributes(:default_action => default_action) if sf

  end

  def down
  end
end
