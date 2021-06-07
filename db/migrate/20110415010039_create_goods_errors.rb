# -*- encoding : utf-8 -*-
#coding: utf-8
#多货少货信息
class CreateGoodsErrors < ActiveRecord::Migration
  def self.up
    create_table :goods_errors do |t|
      t.references :carrying_bill,:null => false
      t.references :org,:null => false
      t.references :user
      t.date :bill_date,:null => false
      t.string :except_type,:limit => 10,:null => false
      t.integer :except_num,:default => 1
      t.text :note
      t.string :state,:null => false,:limit => 20

      t.timestamps
    end
  end

  def self.down
    #drop_table :goods_errors
  end
end

