# -*- encoding : utf-8 -*-
#coding: utf-8
#添加客户分级导出功能
class AddExportCustomerFeeInfoFunction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title('客户分级')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('导出')
      sfo.function_obj = {
        :subject => "CustomerFeeInfo",
        :action => :export
      }
      sfo.save!
    end

  end

  def self.down
  end
end

