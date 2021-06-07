#coding: utf-8
#添加处理部门id
class AddOpOrgIdToInStockBill < ActiveRecord::Migration
  def change
    add_column :in_stock_bills, :op_org_id, :integer,:null => false
  end
end
