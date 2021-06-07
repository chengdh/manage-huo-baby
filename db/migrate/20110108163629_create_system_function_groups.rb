# -*- encoding : utf-8 -*-
#coding: utf-8
#系统功能分类
class CreateSystemFunctionGroups < ActiveRecord::Migration
  def self.up
    create_table :system_function_groups do |t|
      t.string :name,:limit => 30,:null => false
      t.integer :order,:default => 1
      t.boolean :is_active,:null => false ,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :system_function_groups
  end
end

