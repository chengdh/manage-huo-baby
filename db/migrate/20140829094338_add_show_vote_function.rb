#coding: utf-8
class AddShowVoteFunction < ActiveRecord::Migration
  def up
  group_name = "投票系统"
    subject_title = "投票"
    subject = "VoteConfig"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'new_vote_vote_configs_path',
      :function => {
        :new_vote=>{:title => "投票"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
