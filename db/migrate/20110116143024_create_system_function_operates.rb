# -*- encoding : utf-8 -*-
#coding: utf-8
#系统功能操作表
class CreateSystemFunctionOperates < ActiveRecord::Migration
  def self.up
    create_table :system_function_operates do |t|
      t.references :system_function,:null => false
      t.string :name,:limit => 30,:null => false
      t.text :function_obj
      t.integer :order,:default => 1
      t.boolean :is_active,:default => true,:null => false

      t.timestamps
    end
    #删除system_function中的相关字段
    remove_column :system_functions,:action_title
    remove_column :system_functions,:function_obj
  end

  def self.down
    drop_table :system_function_operates
    add_column :system_functions,:action_title,:string,:limit => 30
    add_column :system_functions,:function_obj,:text
  end
end

