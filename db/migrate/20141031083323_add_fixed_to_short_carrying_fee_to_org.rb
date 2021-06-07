#coding: utf-8
#添加固定生成到货短途费
class AddFixedToShortCarryingFeeToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :fixed_to_short_carrying_fee, :decimal,:precision => 10,:scale => 2,:default => 0.0
  end
end
