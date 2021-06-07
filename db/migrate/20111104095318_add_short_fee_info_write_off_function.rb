# -*- encoding : utf-8 -*-
#coding: utf-8
class AddShortFeeInfoWriteOffFunction < ActiveRecord::Migration
  def self.up
    #添加短途运费核销功能
    sf = SystemFunction.find_by_subject_title('短途运费管理')
    func_obj =  {
      :subject => "ShortFeeInfo",
      :action => :write_off,
      :conditions =>"{:state => 'draft'}"
    }

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("核销短途运费信息")
      ops.update_attributes(:function_obj => func_obj)
    end
  end

  def self.down
    sf = SystemFunction.find_by_subject_title('短途运费管理')
    if sf
      ops = sf.system_function_operates.find_by_name("核销短途运费信息")
      ops.destroy if ops
    end

  end
end

