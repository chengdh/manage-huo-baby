#coding: utf-8
#向运单表中添加管理费
require 'lhm'
class AddMangeFeeToCarryingBill < ActiveRecord::Migration
  def up
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.add_column(:manage_fee,"DECIMAL(10,2) DEFAULT 0")
    end
  end
  def down
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.remove_column(:manage_fee)
    end
  end
end
