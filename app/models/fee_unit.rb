#coding: utf-8
#分成计量单位
class FeeUnit < ActiveRecord::Base
  PRICE_TYPE_VOLUME = 1
  PRICE_TYPE_WEIGHT = 2
  PRICE_TYPE_QTY = 3
  validates :name,:unit_simp,:price_type, presence: true
  validates :default_price, numericality: true

  def price_type_des
    ret = ""
    ret = "按体积" if price_type == PRICE_TYPE_VOLUME
    ret = "按重量" if price_type == PRICE_TYPE_WEIGHT
    ret = "按数量" if price_type == PRICE_TYPE_QTY
  end
end
