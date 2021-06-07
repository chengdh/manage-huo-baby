# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeGoodsExceptionEditFunction < ActiveRecord::Migration
  def self.up
    #修改理赔修改功能
    sf = SystemFunction.find_by_subject_title('货损理赔')
    func_obj =  {
      :subject => "GoodsException",
      :action => :update_with_submited,
      :conditions => "{:state => ['submited','authorized','compensated','identified'] }"}

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("修改")
      ops.update_attributes(:function_obj => func_obj)
    end

  end

  def self.down
  end
end

