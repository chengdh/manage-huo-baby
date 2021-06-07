#coding: utf-8
#创建欠款提货清单表
class CreateDebtBills < ActiveRecord::Migration
  def change
    create_table :debt_bills do |t|
      t.date :bill_date,:null => false
      t.references :org,:null => false
      t.integer :op_org_id,:null => false
      t.references :user,:null => false
      t.string :state,:limit => 20,:null => false
      t.text :note

      t.timestamps
    end
    add_index :debt_bills,:bill_date
    add_index :debt_bills,:org_id
    add_index :debt_bills,:op_org_id
    add_index :debt_bills,:user_id
    add_index :debt_bills,:state
  end
end
