# -*- encoding : utf-8 -*-
#coding: utf-8
class AddBillNoToActLoadList < ActiveRecord::Migration
  def self.up
    add_column :act_load_lists, :bill_no, :string,:limit => 20
  end

  def self.down
    remove_column :act_load_lists, :bill_no
  end
end

