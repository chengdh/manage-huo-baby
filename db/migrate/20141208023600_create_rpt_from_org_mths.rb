#coding: utf-8
#添加分理处/分公司运费货款统计数据(按月)
class CreateRptFromOrgMths < ActiveRecord::Migration
  def change
    create_table :rpt_from_org_mths do |t|
      t.integer :from_org_id,:null => false
      t.string :mth,:mull => false,:limit => 6
      t.string :pay_type,:null => false,:limit => 20
      t.decimal :sum_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_goods_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_insured_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_k_hand_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_manage_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_from_short_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :sum_to_short_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.integer :sum_goods_num,:default => 0
      t.integer :sum_bill_count,:default => 0

      t.timestamps
    end
  end
end
