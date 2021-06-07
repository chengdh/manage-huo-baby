#coding: utf-8
#给货物装车清单添加中转地
class AddTransitOrgIdToLoadList < ActiveRecord::Migration
  def change
    add_column :load_lists, :transit_org_id, :integer
  end
end
