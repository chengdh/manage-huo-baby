#coding: utf-8
#投票对象基础类
class BaseVoteConfig < ActiveRecord::Base
  self.table_name = "vote_configs"
  has_many :votable_items,:dependent => :destroy,:foreign_key => "vote_config_id"
  has_many :base_vote_config_orgs,:dependent => :destroy
  has_many :orgs,:through => :base_vote_config_orgs
  accepts_nested_attributes_for :base_vote_config_orgs,:allow_destroy => true
  accepts_nested_attributes_for :votable_items,:allow_destroy => true,:reject_if => proc { |attributes| attributes['name'].blank? }
  attr_accessible :expire_date, :mth, :name, :note,:base_vote_config_orgs_attributes,:votable_items_attributes


  validates :name,:mth,:expire_date, :presence => true

  default_value_for :mth do
    Date.today.strftime("%Y%m")
  end
  default_value_for :expire_date do
    Date.today.end_of_month.to_date
  end
end
