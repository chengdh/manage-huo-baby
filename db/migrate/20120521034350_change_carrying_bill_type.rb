#coding: utf-8
class ChangeCarryingBillType < ActiveRecord::Migration
  def up
    # 该操作移到20120424120058中去
    # change_column :carrying_bills,:type,:string,:limit => 100
  end

  def down
    # change_column :carrying_bills,:type,:string,:limit => 20
  end
end
