# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateShortFeeInfoLines < ActiveRecord::Migration
  def self.up
    create_table :short_fee_info_lines do |t|
      t.references :short_fee_info
      t.references :carrying_bill

      t.timestamps
    end
  end

  def self.down
    drop_table :short_fee_info_lines
  end
end

