# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeReturnBillDefaultAction < ActiveRecord::Migration
  #修改返程票据统计的default_action
  def self.up
    sf = SystemFunction.find_by_subject_title("返程票据统计")
    sf.update_attributes(:default_action => 'simple_search_with_created_at_carrying_bills_path(:rpt_type => "rpt_return_goods_sum","search[to_org_id_or_transit_org_id_eq]" => current_user.default_org_id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc")') if sf
  end

  def self.down
  end
end

