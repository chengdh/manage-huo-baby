#coding: utf-8
class VotableItemOrg < ActiveRecord::Base
  belongs_to :votable_item
  belongs_to :org
  # attr_accessible :title, :body
end
