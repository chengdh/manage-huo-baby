# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.references :org
      t.string :name,:null => false,:limit => 60
      t.string :phone,:limit => 20
      t.string :mobile,:limit => 20
      t.string :address,:limit => 60
      t.string :company,:limit => 60
      t.string :code,:limit => 20
      t.string :id_number,:limit => 30
      t.references :bank
      t.string :bank_card,:limit => 30
      t.boolean :is_active,:default => true
      t.decimal :hand_fee_rate,:default => 0.001,:precision => 10,:scale => 3
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end

