#coding: utf-8
#运费减免信息
class CreateAdjustFeeInfos < ActiveRecord::Migration
  def change
    create_table :adjust_fee_infos do |t|
      t.references :org,:null => false
      t.integer :op_org_id,:null => false
      t.references :user
      t.integer :op_user_id
      t.date :bill_date,:null => false
      t.datetime :op_datetime
      t.string :state,:null => false,:default => 'draft'
      t.decimal :adjust_fee,:precision => 10,:scale => 2,:default => 0
      t.text :note
      t.references :carrying_bill

      t.timestamps
    end
    add_index :adjust_fee_infos, :org_id
    add_index :adjust_fee_infos, :op_org_id
    add_index :adjust_fee_infos, :user_id
    add_index :adjust_fee_infos, :op_user_id
    add_index :adjust_fee_infos, :carrying_bill_id
  end
end
