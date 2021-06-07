# -*- encoding : utf-8 -*-
#coding: utf-8
#提货信息
class CreateDeliverInfos < ActiveRecord::Migration
  def self.up
    create_table :deliver_infos do |t|
      t.date :deliver_date,:null => false
      t.references :user #操作员
      t.string :customer_name,:null => false,:limit => 60
      t.string :customer_no,:limit => 30  #提货人身份证号
      t.string :state,:limit => 30   #状态字段
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :deliver_infos
  end
end

