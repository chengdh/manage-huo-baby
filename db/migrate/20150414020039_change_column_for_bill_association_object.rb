#coding: utf-8
#修改列名
class ChangeColumnForBillAssociationObject < ActiveRecord::Migration
  def up
    remove_column :bill_association_objects,:customer_able_id
    remove_column :bill_association_objects,:customer_able_type
    add_column :bill_association_objects,:customerable_id,:integer,:null => false
    add_column :bill_association_objects,:customerable_type,:string,:null => false,:limit => 60

    add_index :bill_association_objects,:customerable_id
    add_index :bill_association_objects,:customerable_type
    add_index :bill_association_objects,:from_customer_id
    add_index :bill_association_objects,:to_customer_id
  end

  def down
  end
end
