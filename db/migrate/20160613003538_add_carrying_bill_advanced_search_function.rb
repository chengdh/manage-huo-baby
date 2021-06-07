#coding: utf-8
#添加高级查询权限
class AddCarryingBillAdvancedSearchFunction < ActiveRecord::Migration
  def up
    subject_title = "运单修改"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('高级查询')
      sfo.function_obj = {
        :subject => "CarryingBill",
        :action => :advanced_search
      }
      sfo.new_function_obj = {
        :subject => "CarryingBill",
        :action => :advanced_search
      }

      sfo.save!
    end
  end

  def self.down
  end

end
