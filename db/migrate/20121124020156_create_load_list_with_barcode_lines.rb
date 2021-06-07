#coding: utf-8
#创建条码装车清单明细
class CreateLoadListWithBarcodeLines < ActiveRecord::Migration
  def change
    create_table :load_list_with_barcode_lines do |t|
      t.references :load_list_with_barcode,:null => false
      t.string :barcode,:null => false,:limit => 20
      t.string :state,:null => false,:default => "draft"

      t.timestamps
    end
    add_index :load_list_with_barcode_lines, :load_list_with_barcode_id
  end
end
