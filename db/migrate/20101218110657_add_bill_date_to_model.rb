# -*- encoding : utf-8 -*-
#coding: utf-8
class AddBillDateToModel < ActiveRecord::Migration
  def self.up
    add_column :payment_lists,:bill_date,:date,:null => false
    add_column :pay_infos,:bill_date,:date,:null => false
    add_column :settlements,:bill_date,:date,:null => false
    add_column :pay_infos,:type,:string,:limit => 20
  end

  def self.down
    remove_column :payment_lists,:bill_date
    remove_column :pay_infos,:bill_date
    remove_column :settlements,:bill_date
    remove_column :pay_infos,:type
  end
end

