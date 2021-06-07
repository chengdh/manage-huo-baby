#coding: utf-8
#分成报表-宇玖
class CreateDivideRptYujius < ActiveRecord::Migration
  def change
    create_table :divide_rpt_yujius do |t|
      t.references :org,:null => false
      t.string :mth,:null => false,:limit => 6
      t.references :user,:null => false
      t.date :bill_date,:null => false
      t.decimal :carrying_fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_carrying_fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :divide_carrying_fee_from,:precision => 15,:scale => 2,:default => 0

      t.decimal :carrying_fee_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_carrying_fee_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :divide_carrying_fee_to,:precision => 15,:scale => 2,:default => 0

      t.decimal :inner_transit_carrying_fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_inner_transit_carrying_fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :divide_inner_transit_carrying_fee_from,:precision => 15,:scale => 2,:default => 0

      t.decimal :inner_transit_carrying_fee_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_inner_transit_carrying_fee_to,:precision => 15,:scale => 2,:default => 0
      t.decimal :divide_inner_transit_carrying_fee_to,:precision => 15,:scale => 2,:default => 0

      t.decimal :outter_transit_carrying_fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :rate_outter_transit_carrying_fee_from,:precision => 15,:scale => 2,:default => 0
      t.decimal :divide_outter_transit_carrying_fee_from,:precision => 15,:scale => 2,:default => 0

      t.string :plus_item_name_1,:limit => 60
      t.decimal :plus_fee_1,:precision => 15,:scale => 2,:default => 0

      t.string :plus_item_name_2,:limit => 60
      t.decimal :plus_fee_2,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_3,:limit => 60
      t.decimal :plus_fee_3,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_4,:limit => 60
      t.decimal :plus_fee_4,:precision => 15,:scale => 2,:default => 0

      t.string :plus_item_name_5,:limit => 60
      t.decimal :plus_fee_5,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_6,:limit => 60
      t.decimal :plus_fee_6,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_7,:limit => 60
      t.decimal :plus_fee_7,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_8,:limit => 60
      t.decimal :plus_fee_8,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_9,:limit => 60
      t.decimal :plus_fee_9,:precision => 15,:scale => 2,:default => 0


      t.string :plus_item_name_10,:limit => 60
      t.decimal :plus_fee_10,:precision => 15,:scale => 2,:default => 0

      t.string :deduct_item_name_1,:limit => 60
      t.decimal :deduct_fee_1,:precision => 15,:scale => 2,:default => 0

      t.string :deduct_item_name_2,:limit => 60
      t.decimal :deduct_fee_2,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_3,:limit => 60
      t.decimal :deduct_fee_3,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_4,:limit => 60
      t.decimal :deduct_fee_4,:precision => 15,:scale => 2,:default => 0

      t.string :deduct_item_name_5,:limit => 60
      t.decimal :deduct_fee_5,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_6,:limit => 60
      t.decimal :deduct_fee_6,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_7,:limit => 60
      t.decimal :deduct_fee_7,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_8,:limit => 60
      t.decimal :deduct_fee_8,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_9,:limit => 60
      t.decimal :deduct_fee_9,:precision => 15,:scale => 2,:default => 0


      t.string :deduct_item_name_10,:limit => 60
      t.decimal :deduct_fee_10,:precision => 15,:scale => 2,:default => 0

      t.string :other_deduct_item_name_1,:limit => 60
      t.decimal :other_deduct_fee_1,:precision => 15,:scale => 2,:default => 0

      t.string :other_deduct_item_name_2,:limit => 60
      t.decimal :other_deduct_fee_2,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_3,:limit => 60
      t.decimal :other_deduct_fee_3,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_4,:limit => 60
      t.decimal :other_deduct_fee_4,:precision => 15,:scale => 2,:default => 0

      t.string :other_deduct_item_name_5,:limit => 60
      t.decimal :other_deduct_fee_5,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_6,:limit => 60
      t.decimal :other_deduct_fee_6,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_7,:limit => 60
      t.decimal :other_deduct_fee_7,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_8,:limit => 60
      t.decimal :other_deduct_fee_8,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_9,:limit => 60
      t.decimal :other_deduct_fee_9,:precision => 15,:scale => 2,:default => 0


      t.string :other_deduct_item_name_10,:limit => 60
      t.decimal :other_deduct_fee_10,:precision => 15,:scale => 2,:default => 0



      t.text :note

      t.string :state,:limit => 30
      t.datetime :confirm_datetime
      t.integer :confirm_user_id

      t.timestamps
    end
    add_index :divide_rpt_yujius, :org_id
    add_index :divide_rpt_yujius, :user_id
  end
end
