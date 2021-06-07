#coding: utf-8
class DeliverRegion < ActiveRecord::Base
  default_scope order("order_by ASC")
  belongs_to :org
  validates :org_id,:name,:province_code,:city_code,:district_code, :presence => true

  def district_desc
    "#{ChinaCity.get(province_code)}>#{ChinaCity.get(city_code)}>#{ChinaCity.get(district_code)}"
  end
  #提货票打印
  def district_desc_for_print
    "#{ChinaCity.get(district_code)}>#{name}"
  end


  def to_s
    "#{district_desc}>#{name}"
  end
end
