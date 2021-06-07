# -*- encoding : utf-8 -*-
#coding: utf-8
#拼音简写
class AddPyToOrg < ActiveRecord::Migration
  def self.up
    add_column :orgs, :py, :string,:limit => 20
  end

  def self.down
    remove_column :orgs, :py
  end
end

