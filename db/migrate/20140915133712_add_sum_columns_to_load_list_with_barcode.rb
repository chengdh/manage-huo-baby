#coding: utf-8
#
class AddSumColumnsToLoadListWithBarcode < ActiveRecord::Migration
  def change
    add_column :load_list_with_barcodes,:sum_goods_count,:integer,:default => 0
    add_column :load_list_with_barcodes,:sum_bills_count,:integer,:default => 0
  end
end
