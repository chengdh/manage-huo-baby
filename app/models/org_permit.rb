#coding: utf-8
class OrgPermit < ActiveRecord::Base
  belongs_to :org
  belongs_to :permit_org,:class_name => "Org"
  # attr_accessible :title, :body
  validates :org_id,:permit_org_id, :presence => true
end
