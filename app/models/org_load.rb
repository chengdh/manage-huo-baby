#coding: utf-8
#装卸组
class OrgLoad < Org
  has_many :org_load_orgs
  has_many :orgs,:through => :org_load_orgs,:conditions => "is_select = 1"
  accepts_nested_attributes_for :org_load_orgs

  #所有的公司列表
  def all_org_load_orgs!
    #Org.where(["is_active= ? and is_visible=? and is_summary=? and parent_id is null",true,true,false]).each do |o|
    Org.where(["is_active= ? and is_visible=? ",true,true]).each do |o|
      self.org_load_orgs.build(:org => o) unless self.org_load_orgs.detect { |the_oso| the_oso.org_id == o.id }
    end
    self.org_load_orgs.to_a.select {|oso| oso.org.is_active?}
  end

end
