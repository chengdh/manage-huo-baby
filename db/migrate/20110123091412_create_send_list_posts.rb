# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateSendListPosts < ActiveRecord::Migration
  def self.up
    create_table :send_list_posts do |t|
      t.date :bill_date
      t.text :note
      t.references :user
      t.references :sender,:null => false
      t.references :org,:null => false

      t.timestamps
    end
    #送货明细对应的核销id
    add_column :send_list_lines,:send_list_post_id,:integer
  end

  def self.down
    drop_table :send_list_posts
    remove_column :send_list_lines,:send_list_post_id
  end
end

