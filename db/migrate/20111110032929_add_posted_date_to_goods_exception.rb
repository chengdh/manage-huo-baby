# -*- encoding : utf-8 -*-
#coding: utf-8
class AddPostedDateToGoodsException < ActiveRecord::Migration
  def self.up
    add_column :goods_exceptions, :posted_date, :date
    #添加理赔核销功能
    sf = SystemFunction.find_by_subject_title('货损理赔')
    func_obj =  {
      :subject => "GoodsException",
      :action => :do_post,
      :conditions =>"{:state => ['compensated','identified']}"
    }

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("付款核销")
      ops.update_attributes(:function_obj => func_obj)
    end

  end

  def self.down
    remove_column :goods_exceptions,:posted_date
    #删除理赔核销功能
    sf = SystemFunction.find_by_subject_title('货损理赔')
    if sf
      ops = sf.system_function_operates.find_by_name("付款核销")
      ops.destroy if ops
    end

  end
end

