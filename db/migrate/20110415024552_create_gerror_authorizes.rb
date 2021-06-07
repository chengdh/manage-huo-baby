# -*- encoding : utf-8 -*-
#coding: utf-8
#多货少货核销信息
class CreateGerrorAuthorizes < ActiveRecord::Migration
  def self.up
    create_table :gerror_authorizes do |t|
      t.date :bill_date,:null => false
      t.references :user
      t.references :goods_error,:null => false
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :gerror_authorizes
  end
end

