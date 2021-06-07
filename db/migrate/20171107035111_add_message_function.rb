#coding: utf-8
class AddMessageFunction < ActiveRecord::Migration
  def up
    #添加system_function
    group_name ="系统管理"
    ##################################通知消息设置###############################################
    subject_title = "系统弹出通知设置"
    subject = "Message"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'messages_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
