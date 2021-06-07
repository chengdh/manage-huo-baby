#coding: utf-8
#给汇款记录添加审核人字段
class AddValidateUserIdToRemittance < ActiveRecord::Migration
  def change
    add_column :remittances, :validate_user_id, :integer
  end
end
