# -*- encoding : utf-8 -*-
#coding: utf-8
#系统设置表
class CreateIlConfigs < ActiveRecord::Migration
  def self.up
    create_table :il_configs do |t|
      t.string :key,:null => false,:limit => 60
      t.string :title,:limit => 60
      t.string :value,:null => false,:limit => 60
      t.timestamps
    end
  end

  def self.down
    drop_table :il_configs
  end
end

