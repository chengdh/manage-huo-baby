#coding: utf-8
class ChangePriceTableColType < ActiveRecord::Migration
  def up
    change_column :price_tables,:price_6,:string,limit: 60
    change_column :price_tables,:price_7,:string,limit: 60
  end

  def down
  end
end
