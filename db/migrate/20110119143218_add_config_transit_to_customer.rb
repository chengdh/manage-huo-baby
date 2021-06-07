# -*- encoding : utf-8 -*-
#coding: utf-8
class AddConfigTransitToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :config_transit_id, :integer
    remove_column :customers,:hand_fee_rate
  end

  def self.down
    remove_column :customers, :config_transit_id
    add_column :customers,:hand_fee_rate,:decimal,:precision => 15,:scale => 3,:default => 0.001
  end
end

