# -*- encoding : utf-8 -*-
#coding: utf-8
#实际装车清单
class CreateActLoadLists < ActiveRecord::Migration
  def self.up
    create_table :act_load_lists do |t|
      t.references :load_list,:null => false
      t.date :bill_date
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.string :note
      t.string :state,:null => false,:limit => 20,:default => "draft"
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :act_load_lists
  end
end

