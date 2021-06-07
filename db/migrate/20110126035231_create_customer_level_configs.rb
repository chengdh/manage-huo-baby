# -*- encoding : utf-8 -*-
#coding: utf-8
#贵宾客户级别设置
class CreateCustomerLevelConfigs < ActiveRecord::Migration
  def self.up
    create_table :customer_level_configs do |t|
      t.references :org,:null => false
      t.string :name,:null => false,:limit => 20
      t.decimal :from_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :to_fee,:precision => 15,:scale => 2,:default => 0


      t.timestamps
    end
  end

  def self.down
    drop_table :customer_level_configs
  end
end

