# -*- encoding : utf-8 -*-
#coding: utf-8
class AddCarryingBillIndex < ActiveRecord::Migration
  def self.up
    add_index :carrying_bills,:transit_bill_no
    add_index :carrying_bills,:area_id
    add_index :carrying_bills,:from_short_fee_state
    add_index :carrying_bills,:to_short_fee_state
    add_index :carrying_bills,:print_counter
  end

  def self.down
  end
end

