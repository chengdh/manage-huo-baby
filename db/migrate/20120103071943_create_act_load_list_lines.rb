# -*- encoding : utf-8 -*-
#coding:utf-8
class CreateActLoadListLines < ActiveRecord::Migration
  def self.up
    create_table :act_load_list_lines do |t|
      t.references :carrying_bill,:null => false
      t.references :act_load_list,:null => false
      t.integer :load_num,:default => 0,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :act_load_list_lines
  end
end

