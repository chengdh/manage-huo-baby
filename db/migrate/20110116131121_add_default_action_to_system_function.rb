# -*- encoding : utf-8 -*-
#coding: utf-8
class AddDefaultActionToSystemFunction < ActiveRecord::Migration
  def self.up
    add_column :system_functions, :default_action, :text
  end

  def self.down
    remove_column :system_functions, :default_action
  end
end

