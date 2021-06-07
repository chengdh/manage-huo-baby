#coding: utf-8
#更新未提货报表和本地未提货报表
class ChangeRptNoDeliveryFunction < ActiveRecord::Migration
  def up
    #修改本地未提货报表default_action
    sf = SystemFunction.find_by_subject_title('本地未提货统计')
    sf.update_attributes(:default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_no_delivery",:show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount",:hide_fields => "","search[state_in]" => ["reached","distributed"],"search[transit_org_id_is_null]" => 1,"search[to_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "exclude_current_ability_orgs_for_select",:to_org_select => "current_ability_orgs_for_select"  )') if sf

    #修改未提货报表default_action
    sf = SystemFunction.find_by_subject_title('未提货报表')
    sf.update_attributes(:default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_no_delivery",:show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount",:hide_fields => "","search[state_in]" => ["reached","distributed"],"search[transit_org_id_is_null]" => 1,"search[from_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "current_ability_orgs_for_select",:to_org_select => "exclude_current_ability_orgs_for_select" )') if sf

  end

  def down
  end
end
