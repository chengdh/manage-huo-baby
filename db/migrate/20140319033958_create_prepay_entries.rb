#coding: utf-8
#创建预付款记账凭证表
class CreatePrepayEntries < ActiveRecord::Migration
  def change
    create_table :prepay_entries do |t|
      t.references :org,:null => false
      t.date :bill_date,:null => false
      t.text :note
      t.decimal :debit,:default => 0,:precision => 15,:scale => 2
      t.decimal :credit,:default => 0,:precision => 15,:scale => 2
      t.decimal :balance,:default => 0,:precision => 15,:scale => 2
      t.integer :entry_type,:default => 1  #0 期初  1 正常记账

      t.timestamps
    end
    add_index :prepay_entries, :org_id
    add_index :prepay_entries, [:org_id,:bill_date]
    add_index :prepay_entries, :entry_type
  end
end
