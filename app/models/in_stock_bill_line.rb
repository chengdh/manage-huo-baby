#coding: utf-8
#在库清单明细
class InStockBillLine < ActiveRecord::Base
  belongs_to :in_stock_bill
  belongs_to :carrying_bill
  validates  :carrying_bill_id,:presence => true
  attr_accessible :in_stock_bill_id,:carrying_bill_id,:note
end
