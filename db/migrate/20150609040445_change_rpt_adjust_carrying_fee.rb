#coding: utf-8
#修改费用调整统计表
class ChangeRptAdjustCarryingFee < ActiveRecord::Migration
  def up
    subject_title = "运费调整统计表"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_adjust_carrying_fee",'+
      ':show_fields =>".carrying_fee_total,.insured_fee,.adjust_carrying_fee_plus,.adjust_carrying_fee_minus",'+
      '"search[from_org_id_eq]" => current_user.default_org.id,'+
      '"search[type_eq]" => "auto_calculate_computer_bill",'+
      ':from_org_select => "current_ability_orgs_for_select",'+
      ':to_org_select => "exclude_current_ability_orgs_for_select" )')
    end

  end

  def down
  end
end
