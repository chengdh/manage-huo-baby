#coding: utf-8
#添加短驳单id到运单表
class AddShortListId2CarryingBill < ActiveRecord::Migration
  def up
    add_column :carrying_bills, :short_list_id, :integer
    add_index :carrying_bills,:short_list_id
  end

  def down
    remove_column :carrying_bills,:short_list_id
    remove_index :carrying_bills,:short_list_id
  end
end
