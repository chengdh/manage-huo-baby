#coding: utf-8
class AddOptTypeToLoadListWithBarcode < ActiveRecord::Migration
  def change
    add_column :load_list_with_barcodes,:op_type,:string,:limit => 60
  end
end
