#coding: utf-8
class ChangeTaskFunction < ActiveRecord::Migration
  def up
    #修改任务管理功能
    subject = "Task"
    sf = SystemFunction.find_by_subject_title('任务管理')
    sf_hash = {
      :subject => subject,
      :function => {
        :update => {:title => "修改",:conditions =>"{:creator_id => user.id,:state => ['draft','saved'] }"}
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
