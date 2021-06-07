#coding: utf-8
#区域信息
class Region < ActiveRecord::Base
  default_value_for :is_active,true
  validates :name, presence: true
  has_many :region_orgs,:dependent => :destroy
  has_many :orgs,:through => :region_orgs

  accepts_nested_attributes_for :region_orgs,:allow_destroy => true,:reject_if => proc { |attributes| attributes['org_id'].blank? }
  def orgs_list
    orgs.join(",")
  end

  def to_s
    name
  end
end
