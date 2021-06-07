#coding: utf-8
class AddDefaultPriceToFeeUnit < ActiveRecord::Migration
  def change
    add_column :fee_units, :default_price, :decimal,:precision => 15,:scale => 2
    add_column :fee_units, :price_type, :integer
  end
end
