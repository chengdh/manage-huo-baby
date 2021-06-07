# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateGoodsFeeSettlementLists < ActiveRecord::Migration
  def self.up
    create_table :goods_fee_settlement_lists do |t|
      t.date :bill_date,:null => false
      t.references :org,:null => false
      t.references :user
      t.string :note
      t.references :post_info,:null => false
      t.decimal :amount_fee,:precision => 15,:scale => 2,:default => 0  #实领金额
      t.decimal :amount_goods_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :amount_hand_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :amount_k_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.integer :amount_bills,:precision => 15,:scale => 2,:default => 0
      t.string :state,:null => false,:default => "DR"
      t.timestamps
    end
  end

  def self.down
    drop_table :goods_fee_settlement_lists
  end
end

