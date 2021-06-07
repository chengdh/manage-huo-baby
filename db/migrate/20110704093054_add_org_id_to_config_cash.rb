# -*- encoding : utf-8 -*-
#coding: utf-8
class AddOrgIdToConfigCash < ActiveRecord::Migration
  def self.up
    #添加针对发货地,到货地的现金手续费的设置
    add_column :config_cashes, :org_id, :integer
    add_column :config_cashes, :to_org_id, :integer
    #添加针对发货地/到货地的转账手续费设置
    add_column :config_transits,:org_id,:integer
    add_column :config_transits,:to_org_id,:integer
  end

  def self.down
    remove_column :config_cashes, :to_org_id
    remove_column :config_cashes, :org_id
    remove_column :config_transits, :to_org_id
    remove_column :config_transits, :org_id

  end
end

