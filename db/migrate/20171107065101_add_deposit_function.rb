#coding: utf-8
class AddDepositFunction < ActiveRecord::Migration
  def up
    #添加system_function
    group_name ="分公司风险管控"
    ##################################通知消息设置###############################################
    subject_title = "保证金缴纳"
    subject = "Deposit"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'deposits_path',
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

  def down
  end
end
