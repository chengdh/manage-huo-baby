#coding: utf-8
#总部分成报表
class AddSummaryOrgDivideFeeFeeRptFunction < ActiveRecord::Migration
  def up
    group_name = "分成报表"
    subject_title = "总部分成报表"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_summary_org_divide_fee",
      :show_fields =>".from_org_divide_fee,.transit_org_divide_fee,.to_org_divide_fee,.summary_org_divide_fee",
      "search[state_ni]" => ["invalided","canceled"],
      :sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",
      :direction => "asc")',
      :subject => subject,
      :function => {
        :rpt_summary_org_divide_fee =>{:title =>"总部分成报表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
