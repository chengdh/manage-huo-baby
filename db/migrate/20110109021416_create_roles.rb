# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name,:null => false,:limit => 30
      t.boolean :is_active,:null => false,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end

