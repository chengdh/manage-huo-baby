#coding: utf-8
#运单入库表
class InventoryIn < ActiveRecord::Base
  attr_accessible :carrying_bill_id, :sum_qty, :to_org_id
  belongs_to :carrying_bill
  belongs_to :org
  validates_presence_of :carrying_bill_id,:org_id
  validates_numericality_of :sum_qty,:greater_than => 0

end
