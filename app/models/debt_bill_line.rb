#coding: utf-8
#欠款提货明细
class DebtBillLine < ActiveRecord::Base
  belongs_to :debt_bill
  belongs_to :carrying_bill
  attr_accessible :note,:carrying_bill_id,:debt_bill_id,:carrying_bill
  validates :carrying_bill_id, :presence => true
end
