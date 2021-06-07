# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateNotifies < ActiveRecord::Migration
  def self.up
    create_table :notifies do |t|
      t.text :notify_text
      t.references :user

      t.timestamps
    end
    #添加system_function
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
    Notify.create(:notify_text => "添加了快捷键功能.n:新建 e:修改 s:保存 f:查询 d:删除 p:打印 x:导出")
  end

  def self.down
    drop_table :notifies
  end
end

