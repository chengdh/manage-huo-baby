# -*- encoding : utf-8 -*-
#coding: utf-8
class AddOrgIdToDeliverInfo < ActiveRecord::Migration
  def self.up
    add_column :deliver_infos, :org_id, :integer,:null => false
  end

  def self.down
    remove_column :deliver_infos, :org_id
  end
end

