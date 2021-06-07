# -*- encoding : utf-8 -*-
#coding: utf-8
class AddPackageToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :package, :string,:limit => 30
  end

  def self.down
    remove_column :carrying_bills, :package
  end
end

