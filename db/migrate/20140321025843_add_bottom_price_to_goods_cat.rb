#coding: utf-8
#给goods_cat添加最低价格
class AddBottomPriceToGoodsCat < ActiveRecord::Migration
  def change
    add_column :goods_cats, :bottom_price, :decimal,:precision => 10,:scale => 2,:default => 0
  end
end
