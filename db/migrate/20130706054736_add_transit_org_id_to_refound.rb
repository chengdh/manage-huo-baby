#coding: utf-8
#给返款单添加中转地
class AddTransitOrgIdToRefound < ActiveRecord::Migration
  def change
    add_column :refounds, :transit_org_id, :integer
  end
end
