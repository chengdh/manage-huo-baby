#coding: utf-8
#同城快运-本地未提货统计
class AddRptLocalTownBillLocalNoDeliveriedFunction < ActiveRecord::Migration
  def up
    group_name="同城快运业务"
    subject_title = "同城快运-本地未提货统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action =>'simple_search_carrying_bills_path('+
      ':without_paginate => 1,'+
      ':rpt_type => "rpt_local_town_bill_local_no_deliveried",'+
      ':show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount",' +
      ':hide_fields => "",'+
      '"search[state_in]" => ["reached","distributed"],'+
      ':bill_types =>["LocalTownBill","HandLocalTownBill"],'+
      '"search[to_org_id_or_transit_org_id_eq]" => current_user.default_org.id,'+
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",'+
      ':direction => "asc")',
      :subject => subject,
      :function => {
        :rpt_local_town_bill_local_no_deliveried =>{:title =>"同城快运-本地未提货统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)


  end

  def down
  end
end
