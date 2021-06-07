#coding: utf-8
#月结客户付款明细
class CreateCustomerPaymentInfoLines < ActiveRecord::Migration
  def change
    create_table :customer_payment_info_lines do |t|
      t.references :customer_payment_info
      t.references :carrying_bill

      t.timestamps
    end
    add_index :customer_payment_info_lines, :customer_payment_info_id
    add_index :customer_payment_info_lines, :carrying_bill_id
  end
end
