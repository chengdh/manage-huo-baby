# -*- encoding : utf-8 -*-
#coding: utf-8
#添加贵宾客户分级所需字段
class AddLevelToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :cur_fee, :decimal,:precision => 15,:scale => 2  #当月产生运费
    add_column :customers, :level, :string,:limit => 20 #当前级别
    add_column :customers, :last_import_mth, :string,:limit => 6  #最后一次导入日期
  end

  def self.down
    remove_column :customers, :last_import_mth
    remove_column :customers, :level
    remove_column :customers, :cur_fee
  end
end

