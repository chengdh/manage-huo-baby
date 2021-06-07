#coding: utf-8
#给现金货款支付添加银行信息
class AddBankToPayInfo < ActiveRecord::Migration
  def change
    add_column :pay_infos, :bank_id, :integer
  end
end
