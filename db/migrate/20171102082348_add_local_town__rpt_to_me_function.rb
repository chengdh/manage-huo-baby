#coding: utf-8
class AddLocalTownRptToMeFunction < ActiveRecord::Migration
  def change
    group_name = "同城快运业务"
    subject_title = "同城快运-始发地收货统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'carrying_bills_path(:rpt_type => "rpt_to_me_local_town_bill","search[type_in]" => ["LocalTownBill","HandLocalTownBill","LocalTownReturnBill"],"search[to_org_id_eq]" => current_user.default_org.id,"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day,:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:show_fields => ".carrying_fee_total,.th_amount" )',
      :subject => subject,
      :function => {
        :rpt_to_me_local_town_bill =>{:title =>"同城快运-始发地收货统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end
end
