# -*- encoding : utf-8 -*-
#coding: utf-8
#客户费用信息,从运单信息中导入
class CreateCustomerFeeInfos < ActiveRecord::Migration
  def self.up
    create_table :customer_fee_infos do |t|
      t.references :org,:null => false
      t.string :mth,:null => false,:limit => 6
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_fee_infos
  end
end

