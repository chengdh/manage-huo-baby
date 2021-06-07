#coding: utf-8
#给act_load_list添加type字段
class AddTypeToActLoadList < ActiveRecord::Migration
  def change
    add_column :act_load_lists, :type, :string,:limit => 60
 end
end
