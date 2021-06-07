#coding: utf-8
#在短途运费报销时添加费用类表字段
#该字段用于记录报销的都是何种费用
class AddFeeTypeToShortFeeInfo < ActiveRecord::Migration
  def change
    add_column :short_fee_infos, :fee_type, :string,:limit => 60,:default => :from,:null => false
  end
end
