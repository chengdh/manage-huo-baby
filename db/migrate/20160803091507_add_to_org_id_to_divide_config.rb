#coding: utf-8
class AddToOrgIdToDivideConfig < ActiveRecord::Migration
  def change
    add_column :divide_configs,:to_org_id,:integer
    add_column :divide_configs,:to_org_divide_rate,:decimal,:precision => 10,:scale => 2,:default => 0
  end
end
