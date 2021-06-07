#coding: utf-8
class RegionOrg < ActiveRecord::Base
  belongs_to :region
  belongs_to :org
end
