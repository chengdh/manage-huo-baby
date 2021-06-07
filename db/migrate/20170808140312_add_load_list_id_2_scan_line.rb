#coding: utf-8
class AddLoadListId2ScanLine < ActiveRecord::Migration
  def up
    add_column :scan_lines,:load_list_id,:integer
  end

  def down
    remove_column :scan_lines,:load_list_id
  end
end
