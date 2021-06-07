#coding: utf-8
class AddRptAdjustCarryingFeeFunction < ActiveRecord::Migration
  def up
    ##############################运单报表#############################################
    group_name = "查询统计"
    subject_title = "运费调整统计表"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_adjust_carrying_fee",'+
      ':show_fields =>".carrying_fee_total,.insured_fee,.adjust_carrying_fee_plus,.adjust_carrying_fee_minus",'+
      '"search[from_org_id_eq]" => current_user.default_org.id,'+
      '"search[type_eq]" => "auto_calculate_computer_bill",'+
      ':from_org_select => "current_ability_orgs_for_select",'+
      ':to_org_select => "exclude_current_ability_orgs_for_select" )',
      :subject => subject,
      :function => {
        :rpt_adjust_carrying_fee =>{:title =>"运费调整统计表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)


  end

  def down
  end
end
