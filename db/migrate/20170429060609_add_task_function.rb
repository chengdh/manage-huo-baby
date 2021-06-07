#coding: utf-8
class AddTaskFunction < ActiveRecord::Migration
  def up
    group_name = "任务管理"
    #################################理赔管理################################################
    subject_title = "任务管理"
    subject = "Task"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'tasks_path("search[audit_state_in]" => ["draft","reject"])',
      :function => {
        :read => {:title => "查看"},
        :read_all => {:title => "查看所有"},
        :destroy => {:title => "删除",:conditions =>"{:creator_id => user.id}"},
        :create => {:title => "新建"}
        # :do_receive => {:title => "任务接收",:conditions =>"{:acceptor_id => user.id,:state => 'sended' }"},
        # :do_report_progress => {:title => "进度上报",:conditions =>"{:acceptor_id => user.id,:state => 'sended' }"},
        # :do_finish => {:title => "完成",:conditions =>"{:acceptor_id => user.id,:state => 'sended' }"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
