#coding: utf-8
class ChangeFromShortFeeInfoFunctionDefaultAction < ActiveRecord::Migration
  def up
    subject_title = "发货短途费申报"
    sf = SystemFunction.find_by_subject_title(subject_title)
    default_action = "from_short_fee_infos_path('search[from_org_id_or_to_org_id_in]' => current_user.current_ability_org_ids,'search[state_eq]' => 'draft')"
    sf.update_attributes(:default_action => default_action ) if sf.present?
  end

  def down
  end
end
