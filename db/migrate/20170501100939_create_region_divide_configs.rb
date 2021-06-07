#coding: utf-8
class CreateRegionDivideConfigs < ActiveRecord::Migration
  def change
    create_table :region_divide_configs do |t|
      t.references :from_region,:null => false
      t.references :to_region,:null => false
      t.decimal :from_rate,:precision => 15,:scale => 2,:default => 0
      t.decimal :to_rate,:precision => 15,:scale => 2,:default => 0
      t.decimal :summary_rate,:precision => 15,:scale => 2,:default => 0
      t.boolean :is_active,:default => true
      t.text :note

      t.timestamps
    end
    add_index :region_divide_configs, :from_region_id
    add_index :region_divide_configs, :to_region_id
  end
end
