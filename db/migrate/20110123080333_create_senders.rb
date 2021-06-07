# -*- encoding : utf-8 -*-
#coding: utf-8
#送货员
class CreateSenders < ActiveRecord::Migration
  def self.up
    create_table :senders do |t|
      t.string :name,:null => false,:limit => 20
      t.references :org,:null => false
      t.string :mobile,:limit => 20
      t.string :address,:limit => 60
      t.boolean :is_active,:null => false,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :senders
  end
end

