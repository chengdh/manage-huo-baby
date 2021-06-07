# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateDistributionLists < ActiveRecord::Migration
  def self.up
    create_table :distribution_lists do |t|
      t.date :bill_date
      t.references :user
      t.integer :org_id,:null => false
      t.text :note
      t.string :state,:limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :distribution_lists
  end
end

