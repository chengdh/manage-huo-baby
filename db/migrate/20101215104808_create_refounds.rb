# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateRefounds < ActiveRecord::Migration
  def self.up
    create_table :refounds do |t|
      t.date :bill_date,:null => false
      t.integer :from_org_id,:null => false  #返款单位
      t.integer :to_org_id,:null => false    #收款单位
      t.string :state,:limit => 20
      t.references :user
      t.text :note
      t.decimal :sum_goods_fee,:default => 0,:precision => 15,:scale => 2
      t.decimal :sum_carrying_fee,:default => 0,:precision => 15,:scale => 2

      t.timestamps
    end
    #为运单添加返款清单关联id
    add_column :carrying_bills,:refound_id,:integer
  end

  def self.down
    drop_table :refounds
    remove_column :carrying_bills,:refound_id
  end
end

