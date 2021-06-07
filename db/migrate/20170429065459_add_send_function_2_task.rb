#coding: utf-8
class AddSendFunction2Task < ActiveRecord::Migration
  def up
    #修改任务管理功能
    subject = "Task"
    sf = SystemFunction.find_by_subject_title('任务管理')
    sf_hash = {
      :subject => subject,
      :function => {
        :do_send => {:title => "任务下发",:conditions =>"{:creator_id => user.id,:state => 'saved' }"},
        :do_audit => {:title => "任务审核",:conditions =>"{:creator_id => user.id,:state => 'finished' }"}
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
