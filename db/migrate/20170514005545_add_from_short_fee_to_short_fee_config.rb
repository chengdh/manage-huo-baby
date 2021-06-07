#coding: utf-8
class AddFromShortFeeToShortFeeConfig < ActiveRecord::Migration
  def change
    add_column :short_fee_configs, :from_short_fee_rate, :decimal,:scale => 2,:precision => 15,:default => 0
    add_column :short_fee_configs, :fixed_from_short_fee, :decimal,:scale => 2,:precision => 15,:default => 0
  end
end
