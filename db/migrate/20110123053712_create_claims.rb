# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateClaims < ActiveRecord::Migration
  def self.up
    create_table :claims do |t|
      t.references :goods_exception,:null => false
      t.references :user
      t.date :bill_date
      t.decimal :act_compensate_fee,:precision => 15,:scale => 2
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :claims
  end
end

