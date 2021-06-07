# -*- encoding : utf-8 -*-
#coding: utf-8
#中转提货信息
class CreateTransitDeliverInfos < ActiveRecord::Migration
  def self.up
    create_table :transit_deliver_infos do |t|
      t.references :org,:null => false
      t.references :uer
      t.date :bill_date,:null => false
      t.text :note
      t.decimal :transit_hand_fee,:precision => 15,:scale => 2
      t.string :state,:limit => 20

      t.timestamps
    end
    add_column :carrying_bills,:transit_deliver_info_id,:integer
  end

  def self.down
    drop_table :transit_deliver_infos
    remove_column :carrying_bills,:transit_deliver_info_id
  end
end

