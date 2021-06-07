#coding: utf-8
class ChangeVipDefaultAction2 < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    if sf.present?
      sf.default_action = 'vips_path("search[org_id_in]" => current_user.current_ability_org_ids)'
      sf.save!
    end

  end

  def down
  end
end
