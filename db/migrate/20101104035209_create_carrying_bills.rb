# -*- encoding : utf-8 -*-
#coding: utf-8
class CreateCarryingBills < ActiveRecord::Migration
  def self.up
    create_table :carrying_bills do |t|
      t.integer :id,:null => false
      t.date    :bill_date,:null => false
      t.string  :bill_no,:limit => 30,:null => false
      t.string  :goods_no,:limit => 30,:null => false
      t.integer :from_customer_id   #发货人id
      t.string  :from_customer_name,:null => false,:limit => 60  #手工录入的发货人姓名
      t.string  :from_customer_phone,:limit => 60
      t.string  :from_customer_mobile,:limit => 60
      t.integer :to_customer_id #收货人id
      t.string  :to_customer_name,:null => false,:limit => 60 #手工录入的收货人姓名
      t.string  :to_customer_phone
      t.string  :to_customer_mobile,:limit => 60

      t.references :from_org  #发货分理处
      t.references :transit_org #中转分理处 只对中转运单有用
      t.references :to_org #到货分理处
      t.string :to_area,:limit => 20  #到货地点,对于不是内部中转的票据,可能需要手工录入到货地点

      t.decimal :insured_amount,:scale => 2,:precision => 10,:default => 0 #保价金额
      t.decimal :insured_rate,:scale => 2,:precision => 10,:default => 0  #保价比例
      t.decimal :insured_fee,:scale => 2,:precision => 10,:default => 0  #保价比例

      t.decimal :carrying_fee,:scale => 2,:precision => 10,:default => 0 #运费
      t.decimal :goods_fee,:scale => 2,:precision => 10,:default => 0 #代收货款
      t.decimal :goods_fee,:scale => 2,:precision => 10,:default => 0 #代收货款
      t.decimal :from_short_carrying_fee,:scale => 2,:precision => 10,:default => 0 #发货地短途运费
      t.decimal :to_short_carrying_fee,:scale => 2,:precision => 10,:default => 0 #到货地短途运费
      t.string :pay_type,:limit => 20,:null => false #运费支付方式
      t.integer :goods_num,:default => 1 #货物件数

      t.decimal :goods_weight,:scale => 2,:precision => 10,:default => 0 #货物重量
      t.decimal :goods_volume,:scale => 2,:precision => 10,:default => 0 #货物体积
      t.string :goods_info #货物信息描述
      t.text :note

      #票据类别分为以下几种
      #普通机打运单
      #普通手工运单
      #普通机打中转运单
      #普通手工中转运单
      #退货运单
      t.string :type,:limit => 20 #票据类别,rails使用
      t.string :state,:limit => 20 #票据状态
      #添加的运单是否完成标志,用于mysql 分区表
      t.boolean :completed,:default => false #处理完成标志
      t.references :user


      t.timestamps
    end
  end

  def self.down
    drop_table :carrying_bills
  end
end
