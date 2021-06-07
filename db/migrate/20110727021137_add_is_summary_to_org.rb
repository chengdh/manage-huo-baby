# -*- encoding : utf-8 -*-
#coding: utf-8
class AddIsSummaryToOrg < ActiveRecord::Migration
  def self.up
    #机构是否总公司标志
    add_column :orgs, :is_summary, :boolean,:default => false
  end

  def self.down
    remove_column :orgs, :is_summary
  end
end

