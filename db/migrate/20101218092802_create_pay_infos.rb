# -*- encoding : utf-8 -*-
#coding: utf-8
#客户提款基类
class CreatePayInfos < ActiveRecord::Migration
  def self.up
    create_table :pay_infos do |t|
      t.references :org
      t.references :user
      t.string :customer_name,:null => false,:limit => 30
      t.string :id_number,:limit => 30
      t.string :state,:limit => 20
      t.text :note

      t.timestamps
    end
    add_column :carrying_bills,:pay_info_id,:integer
  end

  def self.down
    drop_table :pay_infos
    remove_column :carrying_bills,:pay_info_id
  end
end

