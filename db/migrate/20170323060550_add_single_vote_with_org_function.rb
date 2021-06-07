#coding: utf-8
class AddSingleVoteWithOrgFunction < ActiveRecord::Migration
  def up
    group_name = "投票系统"
    subject_title = "投票设置-单选"
    subject = "SingleVoteConfigWithOrg"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'single_vote_config_with_orgs_path',
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"},
        :show_sum => {:title => "投票情况统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
