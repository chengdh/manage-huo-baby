#coding: utf-8
#创建库存移动表
class CreateInventoryMove < ActiveRecord::Migration
  def change 
    create_table :inventory_moves do |t|
      t.references :inventory
      t.references :carrying_bill,:null => false
      t.references :from_org,:null => false
      t.references :to_org,:null => false
      t.datetime :move_datetime,:null => false
      t.decimal :qty,:precision => 10,:scale => 2,:default => 0,:null => false  #库存移动数量
      t.string :state,:limit => 60,:null => false,:default => 'billed'
    end

    add_index :inventory_moves,:inventory_id
    add_index :inventory_moves,:carrying_bill_id
    add_index :inventory_moves,:from_org_id
    add_index :inventory_moves,:to_org_id
    add_index :inventory_moves,:state
  end

end
