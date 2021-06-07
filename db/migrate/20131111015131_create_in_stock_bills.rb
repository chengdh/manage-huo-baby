#coding: utf-8
#实际未提货物列表
#因存在欠款提货的情况,这时分公司或分理处是不做账的,系统中需要区分:
#A 实际未提 B 欠款提货
class CreateInStockBills < ActiveRecord::Migration
  def change
    create_table :in_stock_bills do |t|
      t.date :bill_date,:null => false
      t.integer :org_id,:null => false
      t.text :note
      t.integer :user_id
      t.string :state,:null => false,:default => "draft"

      t.timestamps
    end
  end
end
