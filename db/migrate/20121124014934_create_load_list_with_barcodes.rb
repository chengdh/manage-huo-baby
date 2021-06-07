#coding: utf-8
#添加基于条码的装车清单表
class CreateLoadListWithBarcodes < ActiveRecord::Migration
  def change
    create_table :load_list_with_barcodes do |t|
      t.integer :to_org_id,:null => false
      t.string :bill_no,:limit => 20
      t.date :bill_date,:null => false
      t.text :note
      t.integer :user_id
      t.string :state,:null => false,:lmit => 20,:default => "draft"
      t.date :confirm_date
      t.integer :confirmer_id
      t.timestamps
    end
  end
end
