#coding: utf-8
#添加异常数量
class AddExceptionNum2ActLine < ActiveRecord::Migration
  def up
    add_column :act_load_list_lines,:exception_num,:integer,:default =>0
  end

  def down
  end
end
