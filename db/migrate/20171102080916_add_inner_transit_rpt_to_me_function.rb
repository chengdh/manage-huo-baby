#coding: utf-8
class AddInnerTransitRptToMeFunction < ActiveRecord::Migration
  def change
    group_name = "内部中转业务"
    subject_title = "内部中转-始发地收货统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'carrying_bills_path(:rpt_type => "rpt_to_me_inner_transit_bill","search[type_in]" => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"],"search[to_org_id_eq]" => current_user.default_org.id,"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day,:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:show_fields => ".carrying_fee_total,.th_amount" )',
      :subject => subject,
      :function => {
        :rpt_to_me_inner_transit_bill =>{:title =>"内部中转-始发地收货统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end
end
