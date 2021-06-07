# -*- encoding : utf-8 -*-
#coding: utf-8
class AddPrintCounterToCarryingBill < ActiveRecord::Migration
  def self.up
    #添加打印计数
    add_column :carrying_bills, :print_counter, :integer,:default => 0,:null => false
  end

  def self.down
    remove_column :carrying_bills, :print_counter
  end
end

