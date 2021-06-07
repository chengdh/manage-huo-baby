# -*- encoding : utf-8 -*-
#coding: utf-8
class AddAccountToPayInfo < ActiveRecord::Migration
  def self.up
    add_column :pay_infos, :account_name, :string,:limit => 20
    add_column :pay_infos, :account_no, :string,:limit => 30
  end

  def self.down
    remove_column :pay_infos, :account_no
    remove_column :pay_infos, :account_name
  end
end

