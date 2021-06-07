#coding: utf-8
#给运单表添加additional_state additional_note字段
class AddAdditionalStateToCarryingBill < ActiveRecord::Migration
  def change
    Lhm.change_table :carrying_bills,:atomic_switch => true  do |m|
      m.add_column :additional_state,"varchar(30) DEFAULT 'draft'"
      m.add_column :additional_note,"varchar(120)"
    end
  end
end
