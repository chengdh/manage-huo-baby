# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateBillNos < ActiveRecord::Migration
  def self.up
    create_table :bill_nos do |t|
      t.integer :bill_count,:default => 4000000
      t.timestamps
    end
  end

  def self.down
    drop_table :bill_nos
  end
end
