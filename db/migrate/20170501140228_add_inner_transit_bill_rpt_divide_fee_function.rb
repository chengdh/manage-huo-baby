#coding: utf-8
class AddInnerTransitBillRptDivideFeeFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "分成报表"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_inner_transit_bill_divide_fee",
      :show_fields =>".from_org_divide_fee,.to_org_divide_fee,.summary_org_divide_fee",
      "search[state_ni]" => ["invalided","canceled"],
      "search[type_in]" => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"],
      :sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",
      :direction => "asc",
      :from_org_select => "inner_bill_to_orgs_list",
      :to_org_select => "inner_bill_to_orgs_list")',
      :subject => subject,
      :function => {
        :rpt_inner_transit_bill_divide_fee => {:title =>"内部中转分成报表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
