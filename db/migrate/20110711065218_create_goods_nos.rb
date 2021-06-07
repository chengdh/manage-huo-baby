# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateGoodsNos < ActiveRecord::Migration
  def self.up
    create_table :goods_nos do |t|
      t.references :from_org,:null => false
      t.references :to_org,:null => false
      t.date :gen_date,:null => false
      t.integer :bill_count,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :goods_nos
  end
end

