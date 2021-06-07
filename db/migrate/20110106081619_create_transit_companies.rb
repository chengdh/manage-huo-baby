# -*- encoding : utf-8 -*-
#coding: utf-8
#中转物流公司信息
class CreateTransitCompanies < ActiveRecord::Migration
  def self.up
    create_table :transit_companies do |t|
      t.string :name,:null => false,:limit => 60
      t.string :address,:limit => 60
      t.string :phone,:limit => 30
      t.boolean :is_active,:default => true
      t.text :note
      t.string :leader,:limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :transit_companies
  end
end

