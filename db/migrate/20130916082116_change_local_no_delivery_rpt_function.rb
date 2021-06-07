#coding: utf-8
#修改本地未提货报表和未提货报表为包含内部中转票据
class ChangeLocalNoDeliveryRptFunction < ActiveRecord::Migration
  def up
    #将内部中转票据包含在查询内
    sf = SystemFunction.find_by_subject_title('本地未提货统计')
    sf.update_attributes(:default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_no_delivery",:bill_types => CarryingBill::BILL_TYPES,:show_fields =>".stranded_days",:hide_fields => ".insured_fee","search[state_in]" => ["reached","distributed"],"search[to_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "exclude_current_ability_orgs_for_select",:to_org_select => "current_ability_orgs_for_select"  )') if sf

    sf = SystemFunction.find_by_subject_title('未提货报表')
    sf.update_attributes(:default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_no_delivery",:bill_types => CarryingBill::BILL_TYPES,:show_fields =>".stranded_days",:hide_fields => ".insured_fee","search[state_in]" => ["reached","distributed"],"search[from_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "current_ability_orgs_for_select",:to_org_select => "exclude_current_ability_orgs_for_select" )') if sf
 
  end

  def down
  end
end
