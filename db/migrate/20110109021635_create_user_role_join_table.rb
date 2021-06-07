# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateUserRoleJoinTable < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.references :user,:role
      t.boolean :is_select,:default => false,:null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_roles
  end
end

