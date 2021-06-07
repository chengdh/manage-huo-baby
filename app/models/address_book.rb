#coding:utf-8
class AddressBook < ActiveRecord::Base
  default_scope order("tag,province_code,city_code,district_code,order_by ASC")
  belongs_to :org
  validates :name,:phone,:address, presence: true

  def location
    "#{ChinaCity.get(province_code)}>#{ChinaCity.get(city_code)}>#{ChinaCity.get(district_code)}"
  end

end
