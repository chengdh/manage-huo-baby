#coding: utf-8
class CreatePriceListLines < ActiveRecord::Migration
  def change
    create_table :price_list_lines do |t|
      t.references :price_list,:null => false
      t.references :fee_unit,:null => false
      t.decimal :price,:precision => 15,:scale => 2,:default => 1
      t.decimal :min_price,:precision => 15,:scale => 2,:default => 1
      t.decimal :divide_rate,:precision => 15,:scale => 2,:default => 0.63

      t.timestamps
    end
    add_index :price_list_lines, :price_list_id
  end
end
