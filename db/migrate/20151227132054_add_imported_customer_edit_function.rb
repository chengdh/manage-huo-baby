#coding: utf-8
class AddImportedCustomerEditFunction < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title('普通客户资料')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('修改')
      function_obj = {
        :subject => "ImportedCustomer",
        :action => :edit
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end
  end
end
