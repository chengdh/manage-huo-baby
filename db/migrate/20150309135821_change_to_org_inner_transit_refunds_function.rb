#coding: utf-8
class ChangeToOrgInnerTransitRefundsFunction < ActiveRecord::Migration
  def up
    subject_title = "中转收款处理"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'to_org_inner_transit_refunds_path("search[state_eq]" => "transit_refunded_confirmed")')
  end

  def down
  end
end
