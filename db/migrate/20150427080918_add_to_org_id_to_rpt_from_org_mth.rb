#coding: utf-8
#添加到货地字段
class AddToOrgIdToRptFromOrgMth < ActiveRecord::Migration
  def change
    add_column :rpt_from_org_mths, :to_org_id, :integer
    change_column :rpt_from_org_mths,:from_org_id,:integer,:null => true
  end
end
