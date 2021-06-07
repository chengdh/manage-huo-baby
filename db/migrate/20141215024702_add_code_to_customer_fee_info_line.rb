#coding: utf-8
#添加客户编号字段
class AddCodeToCustomerFeeInfoLine < ActiveRecord::Migration
  def change
    add_column :customer_fee_info_lines, :code, :string,:limit => 20
  end
end
