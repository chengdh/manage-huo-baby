#coding: utf-8
class AddLimitGoodsFee2Orgs < ActiveRecord::Migration
  def up
    add_column :orgs,:limit_goods_fee,:decimal,:precision => 10,:scale => 2,:default => 9999999
  end

  def down
    remove_column :orgs,:limit_goods_fee
  end
end
