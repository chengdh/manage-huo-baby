#coding: utf-8
class AddOtherAdjustNote2AdjustGoodsFeeInfo < ActiveRecord::Migration
  def up
    add_column :adjust_goods_fee_infos,:other_adjust_note,:string,:limit => 200
  end

  def down
  end
end
