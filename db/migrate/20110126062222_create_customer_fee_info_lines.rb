# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateCustomerFeeInfoLines < ActiveRecord::Migration
  def self.up
    create_table :customer_fee_info_lines do |t|
      t.references :customer_fee_info
      t.string :name,:null => false,:limit => 20
      t.string :phone,:limit => 30
      t.decimal :fee,:precision => 15,:scale => 2,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_fee_info_lines
  end
end

