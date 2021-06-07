# -*- encoding : utf-8 -*-
#coding: utf-8
#送货未交票返回记录
class CreateSendListBacks < ActiveRecord::Migration
  def self.up
    create_table :send_list_backs do |t|
      t.references :org,:null => false
      t.references :sender,:null => false
      t.references :user
      t.date :bill_date
      t.text :note

      t.timestamps
    end
    add_column :send_list_lines,:send_list_back_id,:integer
  end

  def self.down
    drop_table :send_list_backs
    remove_column :send_list_lines,:send_list_back_id
  end
end

