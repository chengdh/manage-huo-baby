#coding: utf-8
class AddMobileToBranchCustomer < ActiveRecord::Migration
  def change
    add_column :customers,:mobile_2,:string,:limit => 20
    add_column :customers,:mobile_3,:string,:limit => 20
    add_column :customers,:mobile_4,:string,:limit => 20
    add_column :customers,:mobile_5,:string,:limit => 20
  end
end
