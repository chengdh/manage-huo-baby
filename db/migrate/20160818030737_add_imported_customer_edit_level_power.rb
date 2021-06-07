#coding: utf-8
class AddImportedCustomerEditLevelPower < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('普通客户资料')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('调整等级')
      function_obj = {
        :subject => "ImportedCustomer",
        :action => :adjust_level
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end

  end

  def down
  end
end
