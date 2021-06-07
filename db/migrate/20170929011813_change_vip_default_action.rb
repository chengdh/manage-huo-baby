#coding: utf-8
class ChangeVipDefaultAction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    if sf.present?
      sf.default_action = 'vips_path()'
      sf.save!
    end
  end

  def down
  end
end
