#coding: utf-8
#货物分类费用设置明细
class CreateGoodsCatFeeConfigLines < ActiveRecord::Migration
  def self.up
    create_table :goods_cat_fee_config_lines do |t|
      t.decimal :bottom_price,:precision => 15,:scale => 2,:default => 0
      t.decimal :unit_price,:precision => 15,:scale => 2,:default => 0
      t.references :goods_cat_fee_config,:null => false
      t.references :goods_cat,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :goods_cat_fee_config_lines
  end
end
