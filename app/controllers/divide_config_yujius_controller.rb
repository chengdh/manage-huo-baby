#coding: utf-8
#运费分成比例设置-宇玖
class DivideConfigYujiusController < BaseController
  table :org,:rate_from,:rate_to,:rate_inner_transit_from,:rate_inner_transit_to,:rate_outter_transit_from,:is_active
end
