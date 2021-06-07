#coding: utf-8
#添加送货区域选项
class CreateDeliverRegions < ActiveRecord::Migration
  def change
    create_table :deliver_regions do |t|
      t.references :org,:null => false
      t.string :name,:null => false,:limit => 60
      t.string :province_code
      t.string :city_code
      t.string :district_code

      t.text :note
      t.boolean :is_active,:default => true
      t.integer :order_by

      t.timestamps
    end
    add_index :deliver_regions, :org_id
    add_index :deliver_regions, :province_code
    add_index :deliver_regions, :city_code
    add_index :deliver_regions, :district_code
  end
end
