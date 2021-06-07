# -*- encoding : utf-8 -*-
#coding: utf-8
class CreatePostInfos < ActiveRecord::Migration
  def self.up
    create_table :post_infos do |t|
      t.references :org
      t.references :user
      t.text :note
      t.date :bill_date,:null => false
      t.decimal :amount_fee,:precision => 15,:scale => 2,:default => 0
      t.string :state,:limit => 20

      t.timestamps
    end
    #运单添加结帐关联id
    add_column :carrying_bills,:post_info_id,:integer
  end

  def self.down
    drop_table :post_infos
    remove_column :carrying_bills,:post_info_id
  end
end

