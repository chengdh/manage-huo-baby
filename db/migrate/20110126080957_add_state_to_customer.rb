# -*- encoding : utf-8 -*-
#coding: utf-8
class AddStateToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :state, :string,:limit => 20
  end

  def self.down
    remove_column :customers, :state
  end
end

