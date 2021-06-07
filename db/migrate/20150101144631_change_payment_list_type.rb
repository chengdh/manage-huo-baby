#coding: utf-8
class ChangePaymentListType < ActiveRecord::Migration
  def up
    change_column :payment_lists,:type,:string,:limit => 60
  end

  def down
  end
end
