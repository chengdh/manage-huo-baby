# -*- encoding : utf-8 -*-
#coding: utf-8
#中转票据信息
class CreateTransitInfos < ActiveRecord::Migration
  def self.up
    create_table :transit_infos do |t|
      t.references :org,:null => false  #中转信息所属机构
      t.references :user               #当前操作员
      t.references :transit_company,:null => false    #中转公司
      t.string :to_station_phone,:limit => 30 #到站分公司电话
      t.date :bill_date,:null => false #中转时间
      t.string :state,:limit => 20
      t.decimal :transit_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.text :note

      t.timestamps
    end
    #向运单表中添加相关字段
    add_column :carrying_bills,:transit_info_id,:integer
    add_column :carrying_bills,:transit_carrying_fee,:decimal,:default => 0,:precision => 15,:scale => 2  #中转运费
    add_column :carrying_bills,:transit_hand_fee,:decimal,:default => 0,:precision => 15,:scale => 2 #中转手续费
  end

  def self.down
    drop_table :transit_infos
    remove_column :carrying_bills,:transit_info_id
    remove_column :carrying_bills,:transit_carrying_fee
    remove_column :carrying_bills,:transit_hand_fee

  end
end

