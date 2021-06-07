# -*- encoding : utf-8 -*-
#coding: utf-8
class AddActLoadListFunction < ActiveRecord::Migration
  def self.up
    group_name = "配送管理"
    ##############################货物运输清单管理#############################################
    subject_title = "装车清单管理"
    subject = "ActLoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'act_load_lists_path("search[from_org_id_in]" => current_user.current_ability_org_ids)',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"},
      :destroy => {:title => "删除",:conditions =>"{:from_org_id => user.current_ability_org_ids}"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def self.down
  end
end

