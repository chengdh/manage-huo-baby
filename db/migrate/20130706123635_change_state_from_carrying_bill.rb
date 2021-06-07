#coding: utf-8
#修改state的长度
require 'lhm'
class ChangeStateFromCarryingBill < ActiveRecord::Migration
  def up
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.change_column(:state,"VARCHAR(60)")
      m.add_column(:carrying_fee_1st,"DECIMAL(10,2) DEFAULT 0")
      m.add_column(:carrying_fee_2st,"DECIMAL(10,2) DEFAULT 0")
    end
  end

  def down
    Lhm.change_table :carrying_bills,:atomic_switch => true do |m|
      m.remove_column(:carrying_fee_1st)
      m.remove_column(:carrying_fee_1st)
    end

  end
end
