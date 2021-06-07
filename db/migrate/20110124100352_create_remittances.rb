# -*- encoding : utf-8 -*-
#coding: utf-8
#汇款记录
class CreateRemittances < ActiveRecord::Migration
  def self.up
    create_table :remittances do |t|
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.date :bill_date,:null => false
      t.references :user
      t.references :refound,:null => false
      t.text :note
      t.decimal :should_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :act_fee,:precision => 15,:scale => 2,:default => 0
      t.string :state,:limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :remittances
  end
end

