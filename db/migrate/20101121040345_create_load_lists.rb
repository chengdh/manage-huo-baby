# -*- encoding : utf-8 -*-
#coding: utf-8
#大车装车清单
class CreateLoadLists < ActiveRecord::Migration
  def self.up
    create_table :load_lists do |t|
      t.date :bill_date
      t.string :bill_no,:limit => 20
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.string :state,:limit => 20
      t.text :note
      t.string :driver,:limit => 20
      t.string :vehicle_no,:limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :load_lists
  end
end

