#coding: utf-8
#向运单表中添加运费调整字段
require 'lhm'
class AddAdjustCarryingFeeToCarryingBill < ActiveRecord::Migration
  def up
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.add_column(:adjust_carrying_fee,"DECIMAL(10,2) DEFAULT 0")
    end
  end
  def down
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.remove_column(:adjust_carrying_fee)
    end
  end
end
