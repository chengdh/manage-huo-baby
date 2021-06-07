# -*- encoding : utf-8 -*-
#coding: utf-8
class AddIsYardToOrg < ActiveRecord::Migration
  def self.up
    #是否中转中心
    add_column :orgs, :is_yard, :boolean,:default => false
  end

  def self.down
    remove_column :orgs, :is_yard
  end
end

