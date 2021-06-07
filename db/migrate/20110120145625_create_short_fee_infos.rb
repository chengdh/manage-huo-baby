# -*- encoding : utf-8 -*-
#coding: utf-8
#短途运费管理
class CreateShortFeeInfos < ActiveRecord::Migration
  def self.up
    create_table :short_fee_infos do |t|
      t.date :bill_date,:null => false
      t.references :org,:null => false
      t.references :user
      t.string :state,:limit => 20
      t.text :note

      t.timestamps
    end
    #短途运费状态
    add_column :carrying_bills,:short_fee_state,:string,:limit => 20
    add_column :carrying_bills,:short_fee_info_id,:integer
  end

  def self.down
    drop_table :short_fee_infos
    remove_column :carrying_bills,:short_fee_state
    remove_column :carrying_bills,:short_fee_info_id
  end
end

