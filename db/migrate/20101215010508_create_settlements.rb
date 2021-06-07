# -*- encoding : utf-8 -*-
#coding: utf-8
#返程运单日结
class CreateSettlements < ActiveRecord::Migration
  def self.up
    create_table :settlements do |t|
      t.string :title,:limit => 60
      t.references :org,:null => false  #结算机构
      t.decimal :sum_goods_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.references :user
      t.text :note
      t.string :state,:limit => 20

      t.timestamps
    end
    #给运单添加结算表的外键
    add_column :carrying_bills,:settlement_id,:integer
  end

  def self.down
    drop_table :settlements
    remove_column :carrying_bills,:settlement_id
  end
end

