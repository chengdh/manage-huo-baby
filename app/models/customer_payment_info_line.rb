#coding: utf-8
#月结客户付款明细
class CustomerPaymentInfoLine < ActiveRecord::Base
  belongs_to :customer_payment_info
  belongs_to :carrying_bill
end
