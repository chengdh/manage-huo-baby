#coding: utf-8
#修改运单报表
class ChangeRptBillsByCreatedAt < ActiveRecord::Migration
  def up
    subject_title = "运单报表-按生成时间"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_bills_by_created_at",'+
                           ':show_fields =>".carrying_fee_total,.insured_fee",'+
                           ':hide_fields =>".bill_date,.carrying_fee,.from_org,.state,.note",'+
                           '"search[from_org_id_eq]" => current_user.default_org.id,'+
                           ':sort => "carrying_bills.created_at",'+
                           ':dont_sort_in_view => 1,' +
                           ':direction => "desc",'+
                           ':from_org_select => "current_ability_orgs_for_select",'+
                           ':to_org_select => "exclude_current_ability_orgs_for_select" )')
    end
  end

  def down
  end
end
