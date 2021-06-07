#coding: utf-8
#添加司机/车辆/电话/
class AddDriverToLoadListWithBarcode < ActiveRecord::Migration
  def change
    add_column :load_list_with_barcodes,:driver,:string,:limit => 30
    add_column :load_list_with_barcodes,:vehicle_no,:string,:limit => 30
    add_column :load_list_with_barcodes,:mobile,:string,:limit => 30

    #添加备注信息
    add_column :load_list_with_barcode_lines,:note,:string,:limit => 300
    #添加扫码照片信息
    add_attachment :load_list_with_barcode_lines, :goods_photo_1
    add_attachment :load_list_with_barcode_lines, :goods_photo_2
  end
end
