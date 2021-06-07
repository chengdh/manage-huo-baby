# -*- encoding : utf-8 -*-
#coding: utf-8
#运单对应的提货信息id
class AddDeliverInfoIdToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :deliver_info_id, :integer
  end

  def self.down
    remove_column :carrying_bills, :deliver_info_id
  end
end

