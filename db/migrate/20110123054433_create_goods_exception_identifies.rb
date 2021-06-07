# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateGoodsExceptionIdentifies < ActiveRecord::Migration
  def self.up
    create_table :goods_exception_identifies do |t|
      t.date :bill_date,:null => false
      t.text :note
      t.references :goods_exception,:null => false
      t.references :user
      t.decimal :from_org_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :to_org_fee,:precision => 15,:scale => 2,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :goods_exception_identifies
  end
end

