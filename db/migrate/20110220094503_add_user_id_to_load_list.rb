# -*- encoding : utf-8 -*-
#coding: utf-8
class AddUserIdToLoadList < ActiveRecord::Migration
  def self.up
    add_column :load_lists, :user_id, :integer
  end

  def self.down
    remove_column :load_lists, :user_id
  end
end

