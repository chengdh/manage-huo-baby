#coding: utf-8
#汇款记录添加字段
class AddColsToRemittance < ActiveRecord::Migration
  def change
    #内部中转应支付费用
    add_column :remittances,:inner_transit_refund_should_fee,:decimal,:precision => 15,:scale => 2 ,:default => 0
    add_column :remittances,:pos_fee,:decimal,:precision => 15,:scale => 2 ,:default => 0
    add_column :remittances,:quick_fee,:decimal,:precision => 15,:scale => 2 ,:default => 0
    add_column :remittances,:other_fee,:decimal,:precision => 15,:scale => 2 ,:default => 0
    #add_column :remittances,:inner_transit_refund_id,:integer
  end
end
