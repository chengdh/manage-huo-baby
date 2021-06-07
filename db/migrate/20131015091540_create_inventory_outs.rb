#coding: utf-8
#建立运单出库表
class CreateInventoryOuts < ActiveRecord::Migration
  def change
    create_table :inventory_outs do |t|
      t.integer :carrying_bill_id,:null => false
      t.integer :org_id,:null => false
      t.decimal :sum_qty,:scale => 2,:precision => 10,:default => 0

      t.timestamps
    end
    add_index :inventory_outs,:carrying_bill_id
    add_index :inventory_outs,:org_id
  end
end
