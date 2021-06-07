#coding: utf-8
class AddIsSelectToOrgSortingOrg < ActiveRecord::Migration
  def change
    add_column :org_sorting_orgs, :is_select, :boolean,:default => false
  end
end
