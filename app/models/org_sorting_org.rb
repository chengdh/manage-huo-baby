#coding: utf-8
#分拣组管理机构
class OrgSortingOrg < ActiveRecord::Base
  belongs_to :org_sorting
  belongs_to :org
  # attr_accessible :title, :body
end
