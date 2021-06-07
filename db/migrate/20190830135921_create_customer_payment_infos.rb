#coding: utf-8
#月结客户付款
class CreateCustomerPaymentInfos < ActiveRecord::Migration
  def change
    create_table :customer_payment_infos do |t|
      t.string :bill_no,:limit => 20
      t.date :bill_date,:null => false
      t.string :customer_name,:limit => 30,:null => false
      t.string :customer_id_no,:limit => 60
      t.string :pay_type,:null => false,:limit => 40
      t.string :pay_ref,:limit => 60
      t.text :note
      t.references :from_org,:null => false
      t.references :user
      t.datetime :confirm_datetime
      t.integer :confirm_user
      t.string :state

      t.timestamps
    end
    add_index :customer_payment_infos, :user_id
  end
end
