#coding: utf-8
#添加分理处货款收支清单字段
class AddAmountKInsuredFeeToGoodsFeeSettlement < ActiveRecord::Migration
  def change
    add_column :goods_fee_settlement_lists, :amount_k_insured_fee, :decimal,:default => 0,:scale => 2,:precision =>15
    add_column :goods_fee_settlement_lists, :amount_k_from_short_carrying_fee, :decimal,:default => 0,:scale => 2,:precision =>15
    add_column :goods_fee_settlement_lists, :amount_k_to_short_carrying_fee, :decimal,:default => 0,:scale => 2,:precision =>15
  end
end
