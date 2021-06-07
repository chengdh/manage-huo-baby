#coding: utf-8
#盘货移动,记录货物自分理处到分公司的移动记录
class InventoryMove <  ActiveRecord::Base
  belongs_to :inventory,:class_name => "ActLoadList"
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :carrying_bill
  validates_presence_of :from_org_id,:to_org_id,:carrying_bill_id
  validates_numericality_of :qty

  default_value_for :move_datetime,DateTime.now
  #state有三种状态,
  #billed 草稿状态,还未生效
  #shipped 已出库,对方还未接收
  #reached 对方已接收
  default_value_for :state,'billed'
end
