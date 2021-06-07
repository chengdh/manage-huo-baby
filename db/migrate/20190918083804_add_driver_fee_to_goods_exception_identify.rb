#coding: utf-8
#添加大车司机赔付费
class AddDriverFeeToGoodsExceptionIdentify < ActiveRecord::Migration
  def change
    add_column :goods_exception_identifies,:driver_fee,:decimal,:default => 0,:scale => 2,:precision => 15
  end
end
