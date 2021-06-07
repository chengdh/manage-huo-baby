#coding: utf-8
#添加manual_set_all字段
class AddManualSetAllToLoadListWithBarcodeLine < ActiveRecord::Migration
  def change
    add_column :load_list_with_barcode_lines,:manual_set_all,:integer,:default => 0
  end
end
