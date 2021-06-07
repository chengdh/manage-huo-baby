#coding: utf-8
class CreateDivideLists < ActiveRecord::Migration
  def change
    create_table :divide_lists do |t|
      t.references :org,:null => false
      t.boolean :is_active,:default => true
      t.decimal :distance_from_summary,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_per_mile,:precision => 15,:scale => 2,:default => 0

      t.text :note

      t.timestamps
    end
    add_index :divide_lists, :org_id
  end
end
