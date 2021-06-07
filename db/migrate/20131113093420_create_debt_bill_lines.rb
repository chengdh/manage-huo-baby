#coding: utf-8
#欠款提货明细
class CreateDebtBillLines < ActiveRecord::Migration
  def change
    create_table :debt_bill_lines do |t|
      t.references :debt_bill,:null => false
      t.references :carrying_bill,:null => false
      t.text :note

      t.timestamps
    end
    add_index :debt_bill_lines, :debt_bill_id
    add_index :debt_bill_lines, :carrying_bill_id
  end
end
