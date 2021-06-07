#coding: utf-8
#添加中转货本地未提货功能
class AddTransitLocalNoDeliveryFunction < ActiveRecord::Migration
  def up
    ##############################本地未提货统计#############################################
    group_name="内部中转业务"
    subject_title = "本地未提货统计(中转)"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "transit_local_rpt_no_delivery",'+
      ':show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount",' +
      ':hide_fields => "",'+
      '"search[state_in]" => ["reached","distributed"],'+
      '"search[transit_org_id_is_not_null]" => 1,'+
      '"search[to_org_id_or_transit_org_id_eq]" => current_user.default_org.id,'+
      ':sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",'+
      ':direction => "asc")',
      :subject => subject,
      :function => {
        :transit_local_rpt_no_delivery =>{:title =>"本地未提货统计(中转)"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
