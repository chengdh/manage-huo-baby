#coding: utf-8
#添加无限制分数投票权限
class AddUnlimitVoteFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("投票")
    if sf
      sfo = sf.system_function_operates.find_by_name("无限制投票")
      if sfo.blank?
        function_obj = {:subject => "VoteConfig",:action => "new_vote_unlimited"}
        sfo = sf.system_function_operates.create(:name => "无限制投票",:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end

  def down
  end
end
