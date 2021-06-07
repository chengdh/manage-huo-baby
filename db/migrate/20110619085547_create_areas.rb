# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :name,:null => false,:limit => 20
      t.integer :order_by,:default => 0
      t.boolean :is_active,:default => true
      t.text :note

      t.timestamps
    end
    remove_column :carrying_bills,:to_area
    add_column :carrying_bills,:area_id,:integer
  end

  def self.down
    drop_table :areas
    remove_column :carrying_bills,:area_id
    add_column :carrying_bills,:to_area,:string,:limit => 20
  end
end

