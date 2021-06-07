# -*- encoding : utf-8 -*-
#coding: utf-8
class AddDistributionListIdToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :distribution_list_id, :integer
  end

  def self.down
    remove_column :carrying_bills, :distribution_list_id
  end
end

