#coding: utf-8
#为货物分类添加默认价格
class AddDefaultPriceToGoodsCat < ActiveRecord::Migration
  def change
    add_column :goods_cats, :default_price, :decimal,:scale => 2,:precision => 10,:default => 0.0 
  end
end
