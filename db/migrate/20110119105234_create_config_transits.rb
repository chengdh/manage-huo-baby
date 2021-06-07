# -*- encoding : utf-8 -*-
#coding: utf-8
#银行转账比例设置
class CreateConfigTransits < ActiveRecord::Migration
  def self.up
    create_table :config_transits do |t|
      t.string :name,:limit => 30,:null => false
      t.decimal :rate,:precision => 10,:scale => 4,:default => 0.001
      t.boolean :is_active,:null => false,:default => true
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :config_transits
  end
end

