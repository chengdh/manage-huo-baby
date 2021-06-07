#coding: utf-8
#添加from_org_id
class AddFromOrgIdToLoadListWithBarcode < ActiveRecord::Migration
  def change
    add_column :load_list_with_barcodes,:from_org_id,:integer,:null => false
    add_index :load_list_with_barcodes,:from_org_id
  end
end
