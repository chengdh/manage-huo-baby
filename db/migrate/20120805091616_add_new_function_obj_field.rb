#coding: utf-8

#在system_function_operates表中添加new_function_obj字段
#该字段用于存储使用marshal序列化后的function obj对象
#原function_obj字段使用YAML序列化,有比较严重的性能问题
class AddNewFunctionObjField < ActiveRecord::Migration
  def change
    add_column :system_function_operates,:new_function_obj,:text
  end
end
