# -*- encoding : utf-8 -*-
#coding: utf-8
#货物一场情况上报
class CreateGoodsExceptions < ActiveRecord::Migration
  def self.up
    create_table :goods_exceptions do |t|
      t.references :org,:null => false
      t.references :carrying_bill
      t.string :exception_type,:limit => 20 #异常情况 少货/短缺/破损
      t.date :bill_date,:null => false
      t.references :user
      t.string :state,:limit => 20
      t.integer :except_num,:default => 1
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :goods_exceptions
  end
end

