#coding: utf-8
#使用lhm在线更新数据结构
require "lhm"
class AddGoodsCatIdToCarryingBill < ActiveRecord::Migration
  def up
    Lhm.change_table :carrying_bills,:atomic_switch => true  do |m|
      m.add_column :goods_cat_id,"int(11)"
      m.add_column :unit_price,"DECIMAL(15,3) DEFAULT 0.0"
      m.change_column :type,"VARCHAR(100)"
      m.add_index :goods_cat_id
    end
  end
  def down
    Lhm.change_table :carrying_bills,:atomic_switch => true  do |m|
      m.remove_column :unit_price
      m.change_column :type,"VARCHAR(20)"
      m.remove_index :goods_cat_id
      m.remove_column :goods_cat_id
    end
  end
end
