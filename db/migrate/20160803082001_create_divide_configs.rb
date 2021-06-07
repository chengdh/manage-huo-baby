#coding: utf-8
#分成比例设置
class CreateDivideConfigs < ActiveRecord::Migration
  def change
    create_table :divide_configs do |t|
      t.string :bill_type,:null => false,:limit => 30
      t.integer :from_org_id
      t.decimal :from_org_divide_rate,:precision => 10,:scale => 2,:default => 0
      t.integer :transit_org_id
      t.decimal :transit_org_divide_rate,:precision => 10,:scale => 2,:default => 0
      t.integer :summary_org_id
      t.decimal :summary_org_divide_rate,:precision => 10,:scale => 2,:default => 0
      t.integer :other_org_1_id
      t.decimal :other_org_1_divide_rate,:precision => 10,:scale => 2,:default => 0
      t.integer :other_org_2_id
      t.decimal :other_org_2_divide_rate,:precision => 10,:scale => 2,:default => 0
      t.integer :other_org_3_id
      t.decimal :other_org_3_divide_rate,:precision => 10,:scale => 2,:default => 0

      t.timestamps
    end
  end
end
