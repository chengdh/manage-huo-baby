#coding: utf-8
#通讯录
class CreateAddressBooks < ActiveRecord::Migration
  def change
    create_table :address_books do |t|
      t.references :org
      t.string :province_code,:limit => 20
      t.string :city_code,:limit => 20
      t.string :district_code,:limit => 20
      t.string :name,:limit => 60,:null => false
      t.string :address,:limit => 60,:null => false
      t.string :phone,:limit => 60,:null => false
      t.integer :order_by
      t.boolean :is_active,:default => true

      t.timestamps
    end
    add_index :address_books, :org_id
  end
end
