#coding: utf-8
class ChangeRptOutterTransitNoDeliveryAddTransitState < ActiveRecord::Migration
  def up
    subject_title = "外部中转-本地未提货统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      default_action ='simple_search_carrying_bills_path('+
      ':without_paginate => 1,'+
      ':rpt_type => "rpt_outter_transit_local_no_deliveried",'+
      ':show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount",' +
      ':hide_fields => "",'+
      '"search[state_in]" => ["reached","transited"],'+
      ':bill_types =>["TransitBill","HandTransitBill","OutterTransitReturnBill"],'+
      '"search[to_org_id_or_transit_org_id_eq]" => current_user.default_org.id,'+
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",'+
      ':direction => "asc")'

      sf.update_attributes(:default_action => default_action)
    end
  end

  def down
  end
end
