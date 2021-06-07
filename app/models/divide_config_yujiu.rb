#coding: utf-8
#运费分成-宇玖
class DivideConfigYujiu < ActiveRecord::Base
  belongs_to :org
  validates :org_id, :presence => true
  validates :rate_from,:rate_to,:rate_inner_transit_from,:rate_inner_transit_to,:rate_outter_transit_from, :numericality => true
end
