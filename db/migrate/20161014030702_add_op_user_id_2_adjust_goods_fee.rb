#coding: utf-8
class AddOpUserId2AdjustGoodsFee < ActiveRecord::Migration
  def up
    add_column :adjust_goods_fee_infos,:op_user_id,:integer
    add_index :adjust_goods_fee_infos,:op_user_id
  end

  def down
  end
end
