# -*- encoding : utf-8 -*-
#coding: utf-8
class AddKHandFeeToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :k_hand_fee, :decimal,:default => 0,:precision=>15 ,:scale => 2
  end

  def self.down
    remove_column :carrying_bills, :k_hand_fee
  end
end

