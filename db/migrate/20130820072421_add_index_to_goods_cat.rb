#coding: utf-8
#添加index到goods_cat
class AddIndexToGoodsCat < ActiveRecord::Migration
  def change
    add_index :goods_cats,:parent_id
    add_index :goods_cats,:order_by
    add_index :goods_cats,:easy_code
    add_index :goods_cats,:is_active


    add_index :goods_cat_fee_configs,:from_org_id
    add_index :goods_cat_fee_configs,:to_org_id
    add_index :goods_cat_fee_configs,:is_active


    add_index :goods_cat_fee_config_lines,:goods_cat_fee_config_id
    add_index :goods_cat_fee_config_lines,:goods_cat_id
  end
end
