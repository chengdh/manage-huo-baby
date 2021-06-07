#coding: utf-8
#返程部分成报表
class AddTransitOrgDivideFeeFeeRptFunction < ActiveRecord::Migration
  def up
    group_name = "分成报表"
    subject_title = "返程部分成报表"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_transit_org_divide_fee",
      :show_fields =>".transit_org_divide_fee",
      "search[state_ni]" => ["invalided","canceled"],
      :sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",
      :direction => "asc",
      :from_org_select => "exclude_current_ability_orgs_for_select",
      :to_org_select => "current_ability_orgs_for_select" )',
      :subject => subject,
      :function => {
        :rpt_transit_org_divide_fee =>{:title =>"返程部分成报表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
