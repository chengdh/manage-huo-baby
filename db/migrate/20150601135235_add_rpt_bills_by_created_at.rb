#coding: utf-8
#添加按照生成时间排序的运单报表
class AddRptBillsByCreatedAt < ActiveRecord::Migration
  def up
    ##############################运单报表#############################################
    group_name = "查询统计"
    subject_title = "运单报表-按生成时间"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_bills_by_created_at",:show_fields =>".carrying_fee_total,.insured_fee,.print_counter","search[from_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.created_at",:direction => "desc",:from_org_select => "current_ability_orgs_for_select",:to_org_select => "exclude_current_ability_orgs_for_select" )',
      :subject => subject,
      :function => {
        :rpt_no_delivery =>{:title =>"运单报表-按生成时间"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
