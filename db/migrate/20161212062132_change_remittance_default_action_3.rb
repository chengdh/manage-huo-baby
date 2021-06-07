#coding: utf-8
class ChangeRemittanceDefaultAction3 < ActiveRecord::Migration
  def up
    subject_title = "汇款记录"
    sf = SystemFunction.find_by_subject_title(subject_title)
    default_action = "current_user.default_org.in_summary? ? remittances_path('search[to_org_id_in]' =>  current_user.current_ability_org_ids, " +
      " 'search[state_in]' => ['draft','complete']) " +
      " : remittances_path('search[from_org_id_in]' => current_user.current_ability_org_ids,"  +
      " 'search[state_in]' => ['draft','complete'])"
    sf.update_attributes(:default_action => default_action)
  end

  def down
  end
end
