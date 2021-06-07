#coding: utf-8
class CreatePriceLists < ActiveRecord::Migration
  def change
    create_table :price_lists do |t|
      t.references :org,:null => false
      t.boolean :is_active,:default => true
      t.text :note

      t.timestamps
    end
    add_index :price_lists, :org_id
  end
end
