#coding: utf-8
class AddIsMonthToVip < ActiveRecord::Migration
  def change
    #是否月结客户
    add_column :customers,:is_month_pay,:boolean,:default => false

    #是否二维码结算客户
    add_column :customers,:is_qrcode_pay,:boolean,:default => false

    add_attachment :customers, :qr_photo_1
    add_attachment :customers, :qr_photo_2
  end
end
