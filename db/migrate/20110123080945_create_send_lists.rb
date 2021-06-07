# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateSendLists < ActiveRecord::Migration
  def self.up
    create_table :send_lists do |t|
      t.date :bill_date,:null => false
      t.references :sender,:null => false
      t.text :note
      t.references :org,:null => false
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :send_lists
  end
end

