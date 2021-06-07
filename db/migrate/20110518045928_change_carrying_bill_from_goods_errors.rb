# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeCarryingBillFromGoodsErrors < ActiveRecord::Migration
  def self.up
    change_column :goods_errors,:carrying_bill_id,:integer,:null => true
  end

  def self.down
    change_column :goods_errors,:carrying_bill_id,:integer,:null => false
  end
end

