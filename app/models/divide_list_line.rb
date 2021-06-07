#coding: utf-8
#分理处分成明细
class DivideListLine < ActiveRecord::Base
  belongs_to :divide_list
  belongs_to :price_list_line
  validates :load_per_vehicle, numericality: true

  #分成比例
  def divide_rate
    return 0.0 if load_per_vehicle.blank? or load_per_vehicle == 0
    divide_cost_fee = IlConfig.divide_cost_fee.to_f
    ret = (divide_cost_fee + divide_list.distance_from_summary * divide_list.price_per_mile/load_per_vehicle)/price_list_line.price
    ret = ret.round(4)
    ret
  end
  def divide_rate_desc
    "#{(divide_rate*100).round(4)}%"
  end
end
