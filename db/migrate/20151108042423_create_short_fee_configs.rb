#coding: utf-8
class CreateShortFeeConfigs < ActiveRecord::Migration
  def change
    create_table :short_fee_configs do |t|
      t.string :name,:limit => 60,:null => false
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.decimal :carrying_fee,:scale => 2,:precision => 15
      t.string :operator,:null => false,:limit => 20
      t.decimal :short_fee_rate,:scale => 2,:precision => 15,:default => 0
      t.decimal :fixed_short_fee,:scale => 2,:precision => 15,:default => 0
      t.boolean :is_active,:default => true
      t.text    :note

      t.timestamps
    end
    add_index :short_fee_configs,:from_org_id
    add_index :short_fee_configs,:to_org_id
  end
end
