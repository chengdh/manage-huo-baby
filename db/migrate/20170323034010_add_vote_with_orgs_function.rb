#coding: utf-8
#投票-按机构
class AddVoteWithOrgsFunction < ActiveRecord::Migration
  def up
    group_name = "投票系统"
    subject_title = "投票设置-按机构"
    subject = "VoteConfigWithOrg"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'vote_config_with_orgs_path',
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
