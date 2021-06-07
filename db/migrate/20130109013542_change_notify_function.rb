#coding: utf-8
#修改系统提醒功能
class ChangeNotifyFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("通知消息设置")
    unless sf
      group_name ="系统管理"
      ##################################通知消息设置###############################################
      subject_title = "通知消息设置"
      subject = "Notify"
      sf_hash = {
        :group_name => group_name,
        :subject_title => subject_title,
        :default_action => 'notifies_path',
        :subject => subject,
        :function => {
          :read =>{:title => "查看"} ,
          :create => {:title => "新建"},
          :update =>{:title =>"修改"},
          :destroy => {:title => "删除"}
        }
      }
      SystemFunction.create_by_hash(sf_hash)
    end
  end

  def down
  end
end
