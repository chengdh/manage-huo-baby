#coding: utf-8
#原运费
class AddOriginCarryingFeeToAdjustFeeInfo < ActiveRecord::Migration
  def change
    add_column :adjust_fee_infos, :origin_carrying_fee, :decimal,:scale => 2,:precision => 10,:default => 0
  end
end
