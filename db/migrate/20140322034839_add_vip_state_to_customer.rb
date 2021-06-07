#coding: utf-8
#为Vip添加state字段
class AddVipStateToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :vip_state, :string,:null => false,:limit => 20
  end
end
