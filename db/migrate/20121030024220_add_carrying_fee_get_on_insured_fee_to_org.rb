#coding: utf-8
#添加设置,当运费大于等于指定数值时才生成保险费
#保险费金额仍从全局设置中提取
class AddCarryingFeeGetOnInsuredFeeToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :carrying_fee_gte_on_insured_fee, :decimal,:precision => 15,:scale => 2
  end
end
