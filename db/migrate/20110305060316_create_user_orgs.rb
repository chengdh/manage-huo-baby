# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateUserOrgs < ActiveRecord::Migration
  def self.up
    create_table :user_orgs do |t|
      t.references :user,:null => false
      t.references :org,:null => false
      t.boolean :is_select,:default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_orgs
  end
end

