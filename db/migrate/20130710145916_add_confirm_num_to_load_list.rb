#coding: utf-8
#给act_load_list_lines添加确认字段
class AddConfirmNumToLoadList < ActiveRecord::Migration
  def change
    add_column :act_load_list_lines, :confirm_num, :integer,:default => 0
  end
end
