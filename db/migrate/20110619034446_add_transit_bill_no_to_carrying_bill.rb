# -*- encoding : utf-8 -*-
#coding: utf-8
class AddTransitBillNoToCarryingBill < ActiveRecord::Migration
  def self.up
    #中转票号和中转到货地电话
    add_column :carrying_bills,:transit_bill_no,:string,:limit => 20
    add_column :carrying_bills,:transit_to_phone,:string,:limit => 20
  end

  def self.down
    remove_column :carrying_bills,:transit_bill_no
    remove_column :carrying_bills,:transit_to_phone
  end
end

