#coding: utf-8
#添加转账客户修改编号功能
class AddEditCode2VipFunciton < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('修改客户编号')
      func_obj = {
        :subject => "Vip",
        :action => :edit_code
      }
      sfo.function_obj = func_obj
      sfo.new_function_obj = func_obj
      sfo.save!
    end


  end

  def down
  end
end
