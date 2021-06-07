# -*- encoding : utf-8 -*-
#coding: utf-8
class AddBuildActLoadListFunction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title('货物运输清单管理')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('生成实际装车清单')
      sfo.function_obj = {
        :subject => "LoadList",
        :action => :build_act_load_list
      }
      sfo.save!
    end

  end

  def self.down
  end
end

