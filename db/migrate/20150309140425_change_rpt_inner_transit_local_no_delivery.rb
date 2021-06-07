#coding: utf-8
class ChangeRptInnerTransitLocalNoDelivery < ActiveRecord::Migration
  def up
    ##############################本地未提货统计#############################################
    subject_title = "本地未提货统计(中转)"
    sf = SystemFunction.find_by_subject_title(subject_title)
    default_action = 'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_inner_transit_local_no_delivery",'+
      ':show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount",' +
      ':hide_fields => "",'+
      '"search[state_in]" => ["reached","distributed"],'+
      '"search[transit_org_id_is_not_null]" => 1,'+
      '"search[to_org_id_or_transit_org_id_eq]" => current_user.default_org.id,'+
      '"search[type_in][]" => "InnerTransitBill",'+
      '"search[type_in][]" => "HandInnerTransitBill",'+
      '"search[type_in][]" => "InnerTransitReturnBill",'+
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",'+
      ':direction => "asc")'
    sf.update_attributes(:default_action => default_action) if sf
 
  end

  def down
  end
end
