#coding: utf-8
#添加货款调整模块
class CreateAdjustGoodsFeeInfos < ActiveRecord::Migration
  def change
    create_table :adjust_goods_fee_infos do |t|
      t.references :org,:null => false
      t.integer :op_org_id,:null => false
      t.references :user,:null => false
      t.date :bill_date,:null=> false
      t.datetime :op_datetime
      t.string :state,:null => false,:default => "draft"
      t.references :carrying_bill,:null => false
      t.decimal :origin_goods_fee,:precision => 15,:scale => 2
      t.decimal :adjust_goods_fee,:precision => 15,:scale => 2
      t.text :note

      t.timestamps
    end
    add_index :adjust_goods_fee_infos, :org_id
    add_index :adjust_goods_fee_infos, :user_id
    add_index :adjust_goods_fee_infos, :carrying_bill_id
  end
end
