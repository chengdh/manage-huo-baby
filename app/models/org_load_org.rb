class OrgLoadOrg < ActiveRecord::Base
  belongs_to :org_load
  belongs_to :org
  # attr_accessible :title, :body
end
