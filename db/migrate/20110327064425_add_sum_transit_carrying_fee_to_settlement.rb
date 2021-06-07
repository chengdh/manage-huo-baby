# -*- encoding : utf-8 -*-
#coding: utf-8
class AddSumTransitCarryingFeeToSettlement < ActiveRecord::Migration
  def self.up
    #合计中转运费
    add_column :settlements, :sum_transit_carrying_fee, :decimal,:scale => 2,:precision => 10,:default => 0
    #合计中转手续费
    add_column :settlements, :sum_transit_hand_fee, :decimal,:scale => 2,:precision => 10,:default => 0
  end

  def self.down
    remove_column :settlements, :sum_transit_carrying_fee
    remove_column :settlements, :sum_transit_hand_fee
  end
end

