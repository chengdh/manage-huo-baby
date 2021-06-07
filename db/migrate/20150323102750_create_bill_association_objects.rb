#coding: utf-8
#添加运单关联的发货人 收货人关联
class CreateBillAssociationObjects < ActiveRecord::Migration
  def change
    create_table :bill_association_objects do |t|
      t.integer :customer_able_id,:null => false
      t.string :customer_able_type,:null => false,:limit => 60
      t.integer :from_customer_id
      t.integer :to_customer_id

      t.timestamps
    end
  end
end
