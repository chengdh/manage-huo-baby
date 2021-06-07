#coding: utf-8
class AddGoodsNameToBillLine < ActiveRecord::Migration
  def change
    Lhm.change_table :bill_lines,:atomic_switch => true do |m|
      m.add_column :name,"VARCHAR(60)"
    end
  end
end
