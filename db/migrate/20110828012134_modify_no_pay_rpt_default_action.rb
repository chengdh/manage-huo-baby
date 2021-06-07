# -*- encoding : utf-8 -*-
#coding: utf-8
class ModifyNoPayRptDefaultAction < ActiveRecord::Migration
  def self.up
    ##############################提货未提款统计#############################################
    subject_title = "提货未提款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_no_pay","search[to_org_id_eq]" => current_user.default_org.id,"search[state_in]" => ["refunded_confirmed","payment_listed"],:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "exclude_current_ability_orgs_for_select",:to_org_select => "current_ability_orgs_for_select" )') if sf.present?

    end

    def self.down
    end
  end

