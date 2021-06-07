#coding: utf-8
module FeeUnitsHelper

  def fee_units_for_select
    FeeUnit.where(:is_active => true).map {|fu| ["#{fu.name}",fu.id]}
  end
  #计价方式列表
  def price_types_for_select
    [['按体积',1],['按重量',2],['按数量',3]]
  end
end
