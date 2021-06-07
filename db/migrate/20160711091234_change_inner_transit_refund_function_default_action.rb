#coding: utf-8
class ChangeInnerTransitRefundFunctionDefaultAction < ActiveRecord::Migration
  def up
    subject_title = "中转返款单(总部处理)"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      sf.update_attributes(:default_action => 'transit_org_inner_transit_refunds_path("search[state_ni]" => ["transit_refunded_confirmed","refunded_confirmed"])')
    end
  end

  def down
  end
end
