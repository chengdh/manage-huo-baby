# -*- encoding : utf-8 -*-
#coding: utf-8
class AddOriginalCarryingFeeToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :original_carrying_fee, :decimal,:precision => 15,:scale => 2,:default => 0

    add_column :carrying_bills, :original_goods_fee, :decimal,:precision => 15,:scale => 2,:default => 0

    add_column :carrying_bills, :original_insured_amount, :decimal,:precision => 15,:scale => 2,:default => 0

    add_column :carrying_bills, :original_insured_fee, :decimal,:precision => 15,:scale => 2,:default => 0

    add_column :carrying_bills, :original_from_short_carrying_fee, :decimal,:precision => 15,:scale => 2,:default => 0

    add_column :carrying_bills, :original_to_short_carrying_fee, :decimal,:precision => 15,:scale => 2,:default => 0

  end

  def self.down
    remove_column :carrying_bills, :original_to_short_carrying_fee
    remove_column :carrying_bills, :original_from_short_carrying_fee
    remove_column :carrying_bills, :original_insured_fee
    remove_column :carrying_bills, :original_insured_amount
    remove_column :carrying_bills, :original_goods_fee
    remove_column :carrying_bills, :original_carrying_fee
  end
end

