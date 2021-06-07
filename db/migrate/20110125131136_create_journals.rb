# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
#coding: utf-8
#日记账
class CreateJournals < ActiveRecord::Migration
  def self.up
    create_table :journals do |t|
      t.references :org,:null => false
      t.date :bill_date,:null => false
      t.references :user
      #已结算未汇金额      
      t.decimal :settled_no_rebate_fee,:precision => 15,:scale => 2,:default => 0
      #已提货未结算金额
      t.decimal :deliveried_no_settled_fee,:precision => 15,:scale => 2,:default => 0
      #可录入项目1,2,3
      t.string :input_name_1,:limit => 20
      t.decimal :input_fee_1,:precision => 15,:scale => 2,:default => 0


      t.string :input_name_2,:limit => 20
      t.decimal :input_fee_2,:precision => 15,:scale => 2,:default => 0

      t.string :input_name_3,:limit => 20
      t.decimal :input_fee_3,:precision => 15,:scale => 2,:default => 0
      #库存现金
      t.decimal :cash,:precision => 15,:scale => 2,:default => 0
      #银行存款
      t.decimal :deposits,:precision => 15,:scale => 2,:default => 0
      #返程货款
      t.decimal :goods_fee,:precision => 15,:scale => 2,:default => 0
      #短途运费及赔偿
      t.decimal :short_fee,:precision => 15,:scale => 2,:default => 0
      #其他开支
      t.decimal :other_fee,:precision => 15,:scale => 2,:default => 0
      #黑票
      t.integer :black_bills,:default => 0
      #红票
      t.integer :red_bills,:default => 0
      #黄票
      t.integer :yellow_bills,:default => 0
      #绿票
      t.integer :green_bills,:default => 0
      #蓝票
      t.integer :blue_bills,:default => 0
      #白票
      t.integer :white_bills,:default => 0
      #客户欠款
      #当日欠款
      t.decimal :current_debt,:precision => 15,:scale => 2,:default => 0
      #2-3日欠款
      t.decimal :current_debt_2_3,:precision => 15,:scale => 2,:default => 0
      #4-5日欠款
      t.decimal :current_debt_4_5,:precision => 15,:scale => 2,:default => 0
      #6日以上欠款
      t.decimal :current_debt_ge_6,:precision => 15,:scale => 2,:default => 0




      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :journals
  end
end

