#coding: utf-8
#运单备注
class BillNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :carrying_bill
  validates :carrying_bill_id,:note, presence: true
end
