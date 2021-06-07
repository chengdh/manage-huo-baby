#coding: utf-8
#添加到货通知清单功能
class AddNoticeFunction < ActiveRecord::Migration
  def self.up
    group_name = "客户关系管理"
    ##############################到货通知清单管理#############################################
    subject_title = "到货通知清单管理"
    subject = "Notice"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'notices_path("search[org_id_in]" => current_user.current_ability_org_ids,"search[state_eq]" => :draft)',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids}"} ,
      :export => {:title => "导出"},
      :update => {:title => "修改",:conditions =>"{:org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:org_id => user.current_ability_org_ids}"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def self.down
  end
end
