#coding: utf-8
#运单出库表
class InventoryOut < ActiveRecord::Base
  attr_accessible :carrying_bill_id, :org_id, :sum_qty
  belongs_to :carrying_bill
  belongs_to :org
  validates_presence_of :carrying_bill_id,:org_id
  validates_numericality_of :sum_qty,:greater_than => 0
end
