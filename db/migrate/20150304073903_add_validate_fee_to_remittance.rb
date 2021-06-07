#coding: utf-8
#添加核对金额字段
class AddValidateFeeToRemittance < ActiveRecord::Migration
  def change
    add_column :remittances,:validate_fee,:decimal,:scale => 2,:precision => 15,:default => 0
  end
end
