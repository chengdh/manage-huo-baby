#coding: utf-8
class AddVoteConfigShowSumFunction < ActiveRecord::Migration
  def up
    group_name = "投票系统"
    subject_title = "投票设置"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo_name = "投票情况统计"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "VoteConfig",
        :action => :show_sum
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!

    end
  end

  def down
  end
end
