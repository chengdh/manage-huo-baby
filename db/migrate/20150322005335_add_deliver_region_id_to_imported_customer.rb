#coding: utf-8
class AddDeliverRegionIdToImportedCustomer < ActiveRecord::Migration
  def change
    #添加送货区域id到客户资料中
    add_column :customers, :deliver_region_id, :integer
  end
end
