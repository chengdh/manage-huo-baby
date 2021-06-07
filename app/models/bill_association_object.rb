#coding: utf-8
class BillAssociationObject < ActiveRecord::Base
  belongs_to :customerable,:polymorphic => true

  belongs_to :from_customer,:class_name => "BranchCustomer"
  belongs_to :to_customer,:class_name => "BranchCustomer"

  belongs_to :other_org_1,:class_name => "Org"
  belongs_to :other_org_2,:class_name => "Org"
  belongs_to :other_org_3,:class_name => "Org"
  belongs_to :other_org_4,:class_name => "Org"

end
