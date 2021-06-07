# -*- encoding : utf-8 -*-
#coding: utf-8
class AddRealNameToUser < ActiveRecord::Migration
  def self.up
    #用户实名
    add_column :users, :real_name, :string,:limit => 20
  end

  def self.down
    remove_column :users, :real_name
  end
end

