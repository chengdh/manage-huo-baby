#coding: utf-8
#分公司运费价格表
class CreatePriceTables < ActiveRecord::Migration
  def change
    create_table :price_tables do |t|
      t.integer :to_org_id,:null => false
      t.string :province_code,:limit => 20
      t.string :city_code,:limit => 20
      t.string :district_code,:limit => 20
      t.string :tag,:limit => 60
      t.decimal :price_1,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_2,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_3,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_4,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_5,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_6,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_7,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_8,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_9,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_10,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_11,:precision => 15,:scale => 2,:default => 0
      t.decimal :price_12,:precision => 15,:scale => 2,:default => 0
      t.integer :order_by,:default => 0
      t.text :note

      t.timestamps
    end
  end
end
