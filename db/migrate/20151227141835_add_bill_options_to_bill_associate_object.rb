#coding: utf-8
#添加票据其他字段
class AddBillOptionsToBillAssociateObject < ActiveRecord::Migration
  def change
    add_column :bill_association_objects,:is_deliver,:boolean,:default => false
    add_column :bill_association_objects,:is_urgent,:boolean,:default => false
    add_column :bill_association_objects,:is_receipt,:boolean,:default => false
    add_column :bill_association_objects,:is_list,:boolean,:default => false
  end
end
