#coding: utf-8
class AddBankToCarryingBill < ActiveRecord::Migration
  def change
    add_column :carrying_bills,:bank_name,:string,:limit => 40
    add_column :carrying_bills,:card_no,:string,:limit => 40
  end
end
