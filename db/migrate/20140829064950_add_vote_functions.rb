#coding: utf-8
#添加投票设置功能
class AddVoteFunctions < ActiveRecord::Migration
  def up
    group_name = "投票系统"
    subject_title = "投票设置"
    subject = "VoteConfig"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'vote_configs_path',
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
