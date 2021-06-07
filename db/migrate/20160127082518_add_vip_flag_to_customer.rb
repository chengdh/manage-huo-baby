#coding: utf-8
#给转账客户添加vip标识
class AddVipFlagToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :vip_flag, :boolean,:default => false
  end
end
