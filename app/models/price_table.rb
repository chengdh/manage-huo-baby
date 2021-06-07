#coding: utf-8
#分公司价格参考表
class PriceTable < ActiveRecord::Base
  default_scope order("province_code,city_code,district_code,order_by ASC")
  belongs_to :to_org,:class_name => "Org"
  validates :to_org_id, presence: true

  def location
    "#{ChinaCity.get(province_code)}>#{ChinaCity.get(city_code)}>#{ChinaCity.get(district_code)}"
  end
end
