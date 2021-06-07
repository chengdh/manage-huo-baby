#coding: utf-8
class BaseVoteConfigOrg < ActiveRecord::Base
  belongs_to :base_votable_config
  belongs_to :org
  # attr_accessible :title, :body
end
