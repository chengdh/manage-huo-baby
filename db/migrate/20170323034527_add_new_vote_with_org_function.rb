#coding: utf-8
class AddNewVoteWithOrgFunction < ActiveRecord::Migration
  def up
    group_name = "投票系统"
    subject_title = "投票-按机构"
    subject = "VoteConfigWithOrg"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'new_vote_vote_config_with_orgs_path',
      :function => {
        :new_vote=>{:title => "投票-按机构"},
        :new_vote_with_org_unlimited => {:title => "无限制投票"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
