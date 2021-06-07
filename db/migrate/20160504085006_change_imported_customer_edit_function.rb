#coding: utf-8
class ChangeImportedCustomerEditFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("普通客户资料")
    if sf.present?
      sfo = sf.system_function_operates.find_by_name('修改')
      function_obj = {
        :subject => "ImportedCustomer",
        :action => :update
      }
      if sfo.present?
        sfo.function_obj = function_obj
        sfo.new_function_obj = function_obj
        sfo.save!
      end
    end
  end

  def down
  end
end
