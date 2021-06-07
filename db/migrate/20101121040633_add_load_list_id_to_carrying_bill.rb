# -*- encoding : utf-8 -*-
#coding: utf-8
#给运单添加装车清单id
class AddLoadListIdToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :load_list_id, :integer
  end

  def self.down
    remove_column :carrying_bills, :load_list_id
  end
end

