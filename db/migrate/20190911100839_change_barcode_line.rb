#coding: utf-8
#修改条码长度
class ChangeBarcodeLine < ActiveRecord::Migration
  def up
    change_column :load_list_with_barcode_lines,:barcode,:string,:limit => 30,:null => false
  end

  def down
    change_column :load_list_with_barcode_lines,:barcode,:string,:limit => 20,:null => false
  end
end
