#coding: utf-8
#创建货品分类
class CreateGoodsCats < ActiveRecord::Migration
  def self.up
    create_table :goods_cats do |t|
      t.string :name,:limit => 60,:null => false
      t.integer :parent_id
      t.integer :order_by,:default => 0
      t.boolean :is_active,:default => true
      t.string :easy_code,:limit => 60
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :goods_cats
  end
end
