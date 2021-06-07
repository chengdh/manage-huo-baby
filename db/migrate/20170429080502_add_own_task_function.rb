#coding: utf-8
class AddOwnTaskFunction < ActiveRecord::Migration
  def up
    group_name = "任务管理"
    #################################理赔管理################################################
    subject_title = "任务上报"
    subject = "Task"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'own_tasks_path("search[state_or_audit_state_in]" => ["sended","accepted","rejected"])',
      :function => {
        :read => {:title => "查看"},
        :do_accept => {:title => "任务接收",:conditions =>"{:state => 'sended' }"},
        :new_progress_page => {:title => "进度上报",:conditions =>"{:state => 'accepted' }"},
        :show_finish_page => {:title => "完成",:conditions =>"{:state => 'accepted' }"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
