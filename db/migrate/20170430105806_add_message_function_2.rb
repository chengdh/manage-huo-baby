#coding: utf-8
class AddMessageFunction2 < ActiveRecord::Migration
  def up
    group_name = "系统管理"
    #################################理赔管理################################################
    subject_title = "通知公告"
    subject = "Message"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'messages_path()',
      :function => {
        :read => {:title => "查看"},
        :create => {:title => "新建"},
        :update => {:title => "修改",:conditions =>"{:state => 'draft'}"},
        :destroy => {:title => "删除",:conditions =>"{:state => 'draft'}"},
        :publish => {:title => "发布",:conditions =>"{:state => 'draft'}"},
        :unpublish => {:title => "草稿",:conditions =>"{:state => 'published'}"}
      }
    }
    #SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
