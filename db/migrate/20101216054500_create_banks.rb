# -*- encoding : utf-8 -*-
#coding: utf-8
#银行资料信息
class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.string :name,:null => false,:lmit => 60
      t.string :code,:null => false,:limit =>20
      t.boolean :is_active,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end

