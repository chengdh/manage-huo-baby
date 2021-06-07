#coding: utf-8
#分成设置-宇玖
class CreateDivideConfigYujius < ActiveRecord::Migration
  def change
    create_table :divide_config_yujius do |t|
      t.references :org,:null => false
      t.decimal :rate_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_inner_transit_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_inner_transit_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_outter_transit_from,:precision => 15,:scale => 2,:default => 0
      t.boolean :is_active,:default => true
      t.timestamps
    end
    add_index :divide_config_yujius, :org_id
  end
end
