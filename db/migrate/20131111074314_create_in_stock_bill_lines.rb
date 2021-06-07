#coding: utf-8
#在库票据明细
class CreateInStockBillLines < ActiveRecord::Migration
  def change
    create_table :in_stock_bill_lines do |t|
      t.references :in_stock_bill,:null => false
      t.references :carrying_bill,:null => false
      t.text :note

      t.timestamps
    end
    add_index :in_stock_bill_lines, :in_stock_bill_id
    add_index :in_stock_bill_lines, :carrying_bill_id
  end
end
