#coding: utf-8
class ScanLine < ActiveRecord::Base
  belongs_to :scan_header
  belongs_to :carrying_bill
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :load_list,:class_name => "BaseLoadList"

  def goods_fee
    carrying_bill.goods_fee
  end
  def carrying_fee
    carrying_bill.carrying_fee
  end
  def from_short_carrying_fee
    carrying_bill.from_short_carrying_fee
  end

  def goods_status_type_des
    ret = "正常"
    ret = "正常" if goods_status_type.eql?(1)
    ret = "破损" if goods_status_type.eql?(90)
    ret = "缺货" if goods_status_type.eql?(91)
    ret = "多货" if goods_status_type.eql?(92)
    ret = "手工录入" if goods_status_type.eql?(93)
    ret
  end
end
