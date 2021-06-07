#coding: utf-8
#修改user_id可为空
class ChangeUserFromDebtBill < ActiveRecord::Migration
  def up
    change_column :debt_bills,:user_id,:integer,:null => true
    change_column :in_stock_bills,:user_id,:integer,:null => true
  end

  def down
  end
end
