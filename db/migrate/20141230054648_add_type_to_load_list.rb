#coding: utf-8
#给load_list添加type字段
class AddTypeToLoadList < ActiveRecord::Migration
  def change
    add_column :load_lists, :type, :string,:limit => 60
  end
end
