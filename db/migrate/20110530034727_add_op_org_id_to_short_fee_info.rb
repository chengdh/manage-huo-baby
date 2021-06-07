# -*- encoding : utf-8 -*-
#coding: utf-8
class AddOpOrgIdToShortFeeInfo < ActiveRecord::Migration
  def self.up
    #给短途运费核销添加核销部门字段
    add_column :short_fee_infos,:op_org_id,:integer
    #给货物异常信息添加处理部门字段
    add_column :goods_exceptions,:op_org_id,:integer
    #多货少货信息
    add_column :goods_errors,:op_org_id,:integer

  end

  def self.down
    remove_column :short_fee_infos,:op_org_id
    remove_column :goods_exceptions,:op_org_id
    remove_column :goods_errors,:op_org_id
  end
end

