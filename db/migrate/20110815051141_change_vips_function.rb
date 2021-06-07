# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeVipsFunction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    if sf.present?
      sf.default_action = 'vips_path("search[org_id_in]" => current_user.current_ability_org_ids)'
      sf.save!
      sfo = sf.system_function_operates.find_by_name('查看')
      sfo.function_obj = {
        :subject => "Vip",
        :action => :read
      }
      sfo.save!
      sfo = sf.system_function_operates.find_by_name('修改')
      sfo.function_obj = {
        :subject => "Vip",
        :action => :update,
        :conditions =>"{:org_id => user.current_ability_org_ids }"
      }
      sfo.save!
      sfo = sf.system_function_operates.find_by_name('删除')
      sfo.function_obj = {
        :subject => "Vip",
        :action => :destroy,
        :conditions =>"{:org_id => user.current_ability_org_ids }"
      }
      sfo.save!
    end
  end

  def self.down
  end
end
