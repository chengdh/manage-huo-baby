# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateGexceptionAuthorizeInfos < ActiveRecord::Migration
  def self.up
    create_table :gexception_authorize_infos do |t|
      t.date :bill_date,:null => false
      t.text :note
      t.string :op_type,:null => false,:limit => 20
      t.decimal :compensation_fee,:precision => 10,:scale => 2,:default => 0
      t.references :user
      t.references :goods_exception

      t.timestamps
    end
  end

  def self.down
    drop_table :gexception_authorize_infos
  end
end

