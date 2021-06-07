#coding: utf-8
class RegionDivideConfig < ActiveRecord::Base
  belongs_to :from_region,:class_name => "Region"
  belongs_to :to_region,:class_name => "Region"
  validates :from_region_id,:to_region_id, presence: true
  validates :from_rate,:to_rate,:summary_rate, numericality: true

  def self.get_config(from_org_id,to_org_id)
    ret = nil
    from_region_id = RegionOrg.find_by_org_id(from_org_id).try(:region_id)
    to_region_id = RegionOrg.find_by_org_id(to_org_id).try(:region_id)
    ret = where(:from_region_id => from_region_id,:to_region_id => to_region_id,:is_active => true).try(:first)
    ret
  end

end
