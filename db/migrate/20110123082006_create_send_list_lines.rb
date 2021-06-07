# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateSendListLines < ActiveRecord::Migration
  def self.up
    create_table :send_list_lines do |t|
      t.references :send_list,:null => false
      t.references :carrying_bill,:null => false
      t.string :state,:limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :send_list_lines
  end
end

