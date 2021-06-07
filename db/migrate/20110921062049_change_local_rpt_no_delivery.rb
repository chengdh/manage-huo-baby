# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeLocalRptNoDelivery < ActiveRecord::Migration
  def self.up
    #修改 本地未提货统计/未提货报表为不分页
    sf = SystemFunction.find_by_subject_title('本地未提货统计')
    sf.update_attributes(:default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_no_delivery",:show_fields =>".stranded_days",:hide_fields => ".insured_fee","search[state_in]" => ["reached","distributed"],"search[to_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "exclude_current_ability_orgs_for_select",:to_org_select => "current_ability_orgs_for_select"  )') if sf

    sf = SystemFunction.find_by_subject_title('未提货报表')
    sf.update_attributes(:default_action =>'simple_search_carrying_bills_path(:without_paginate => 1,:rpt_type => "rpt_no_delivery",:show_fields =>".stranded_days",:hide_fields => ".insured_fee","search[state_in]" => ["reached","distributed"],"search[from_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "current_ability_orgs_for_select",:to_org_select => "exclude_current_ability_orgs_for_select" )') if sf
    sf = SystemFunction.find_by_subject_title('提货未提款统计')
    sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_no_pay","search[to_org_id_eq]" => current_user.default_org.id,"search[state_in]" => ["refunded_confirmed","payment_listed"],"search[goods_fee_gt]" => 0,:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "current_ability_orgs_for_select",:to_org_select => "exclude_current_ability_orgs_for_select" )') if sf
  end

  def self.down
  end
end

