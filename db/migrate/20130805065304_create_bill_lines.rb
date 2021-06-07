#coding: utf-8
#运单明细
class CreateBillLines < ActiveRecord::Migration
  def change
    create_table :bill_lines do |t|
      t.references :carrying_bill,:null => false
      t.references :goods_cat,:null => false
      t.integer :qty,:default => 1
      t.string :package
      t.decimal :volume,:precision => 15, :scale => 2,:default => 0
      t.decimal :weight,:precision => 15, :scale => 2,:default => 0
      t.decimal :price, :precision => 15, :scale => 2,:default => 0
      t.decimal :amt,   :precision => 15, :scale => 2,:default => 0
      t.timestamps
    end
    add_index :bill_lines, :carrying_bill_id
    add_index :bill_lines, :goods_cat_id
  end
end
