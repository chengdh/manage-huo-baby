# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateBasePaymentLists < ActiveRecord::Migration
  def self.up
    create_table :payment_lists do |t|
      t.references :bank
      t.references :org
      t.references :user
      t.string :state,:limit => 20
      t.string :type,:limit => 20
      t.text :note

      t.timestamps
    end
    add_column :carrying_bills,:payment_list_id,:integer
  end

  def self.down
    drop_table :payment_lists
    remove_column :carrying_bills,:payment_list_id
  end
end

