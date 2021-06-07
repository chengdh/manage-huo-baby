#coding: utf-8
#分拣组
class OrgSorting < Org
  has_many :org_sorting_orgs
  has_many :orgs,:through => :org_sorting_orgs
  accepts_nested_attributes_for :org_sorting_orgs

  #所有的分理处列表
  def all_org_sorting_orgs!
    Org.where(["is_active= ? and is_visible=? and is_summary=? and parent_id is not null",true,true,false]).each do |o|
      self.org_sorting_orgs.build(:org => o) unless self.org_sorting_orgs.detect { |the_oso| the_oso.org_id == o.id }
    end
    self.org_sorting_orgs.to_a.select {|oso| oso.org.is_active?}
  end
end
