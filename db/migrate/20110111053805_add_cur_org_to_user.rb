# -*- encoding : utf-8 -*-
#coding: utf-8
class AddCurOrgToUser < ActiveRecord::Migration
  def self.up
    change_column :users,:email,:string,:null => true
    #添加一个默认用户
    #User.create(:username => "admin",:password => "admin",:is_admin => true)
    add_column :users,:default_org_id,:integer
    add_column :users,:default_role_id,:integer
  end

  def self.down
    change_column :users,:email,:string,:null => false

    remove_column :users,:default_org_id
    remove_column :users,:default_role_id
  end
end

