#coding: utf-8
#货物入库表
class CreateInventoryIns < ActiveRecord::Migration
  def change
    create_table :inventory_ins do |t|
      t.integer :carrying_bill_id,:null => false
      t.integer :org_id,:null => false
      t.decimal :sum_qty,:scale => 2,:precision => 10,:default => 0

      t.timestamps
    end
    add_index :inventory_ins,:carrying_bill_id
    add_index :inventory_ins,:org_id
  end
end
