#coding: utf-8
class AddIsStoreToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :is_allocation, :boolean,:default => false
  end
end
