# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeNameFromConfigTransit < ActiveRecord::Migration
  def self.up
    change_column :config_transits,:name,:string,:null => true,:limit => 20
  end

  def self.down
    change_column :config_transits,:name,:string,:null => false,:limit => 20
  end
end

