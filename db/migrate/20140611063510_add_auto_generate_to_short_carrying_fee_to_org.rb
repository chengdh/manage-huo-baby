#coding: utf-8
#添加自动生成到货短途费字段
class AddAutoGenerateToShortCarryingFeeToOrg < ActiveRecord::Migration
  def change
    #是否自动生成到货短途
    add_column :orgs, :auto_generate_to_short_carrying_fee, :boolean,:default => false
    #生成比例
    add_column :orgs, :agtscf_rate, :decimal,:scale => 2,:precision => 10,:default => 0
  end
end
