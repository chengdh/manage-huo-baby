#coding: utf-8
require 'lhm'
class AddTranisitFeeToCarryingBill < ActiveRecord::Migration
=begin
  def change
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.add_column(:carrying_fee_1st,"DECIMAL(10.2) DEFAULT 0")
      m.add_column(:carrying_fee_2st,"DECIMAL(10.2) DEFAULT 0")
    end
  end
=end
end
