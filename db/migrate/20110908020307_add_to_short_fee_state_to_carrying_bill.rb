# -*- encoding : utf-8 -*-
#coding: utf-8
class AddToShortFeeStateToCarryingBill < ActiveRecord::Migration
  def self.up
    #添加to_short_fee_state
    add_column :carrying_bills,:to_short_fee_state,:string,:limit => 20,:default => 'draft'
    #删除short_fee_info_id
    remove_column :carrying_bills,:short_fee_info_id
    #删除short_fee_state
    remove_column :carrying_bills,:short_fee_state
    add_column :carrying_bills,:from_short_fee_state,:string,:limit => 20,:default => 'draft'

  end

  def self.down
    remove_column :carrying_bills,:to_short_fee_state
    add_column :carrying_bills,:short_fee_info_id,:integer
    remove_column :carrying_bills,:from_short_fee_state
    add_column :carrying_bills,:short_fee_state,:string,:limit => 20,:default => 'draft'
  end
end

