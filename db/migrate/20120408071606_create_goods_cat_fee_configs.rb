#coding: utf-8
#货物分类费用设置
class CreateGoodsCatFeeConfigs < ActiveRecord::Migration
  def self.up
    create_table :goods_cat_fee_configs do |t|
      t.integer :from_org_id,:null => false
      t.integer :to_org_id,:null => false
      t.boolean :is_active,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :goods_cat_fee_configs
  end
end
