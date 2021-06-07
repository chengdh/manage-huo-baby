# -*- encoding : utf-8 -*-
#coding: utf-8
#系统功能类
class CreateSystemFunctions < ActiveRecord::Migration
  def self.up
    create_table :system_functions do |t|
      t.references :system_function_group,:null => false
      t.string :subject_title,:null => false,:limit => 30
      t.string :action_title,:null => false,:limit => 30
      t.text :function_obj,:null => false
      t.integer :order,:default => 1
      t.boolean :is_active,:null => false,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :system_functions
  end
end

