#coding: utf-8
#添加服务专员
class AddSalesManToImportedCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :sales_man, :string,:limit => 30
    add_column :customers, :sales_man_mobile, :string,:limit => 30
  end
end
