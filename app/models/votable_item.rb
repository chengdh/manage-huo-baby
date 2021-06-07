#coding: utf-8
class VotableItem < ActiveRecord::Base
  acts_as_votable
  belongs_to :base_vote_config,:foreign_key => "vote_config_id",:class_name => "BaseVoteConfig"
  validates :name, :presence => true
  has_many :votable_item_orgs
  has_many :orgs,:through => :votable_item_orgs
  accepts_nested_attributes_for :votable_item_orgs,:allow_destroy => true
  attr_accessible :name, :note, :order_by,:votable_item_orgs_attributes

  #得到得分百分比
  #top 最高分
  def percent(top = 5)
    #分子
    numerator = find_votes_for(:vote_scope => base_vote_config.id).sum(:vote_weight)
    #分母
    denominator = find_votes_for(:vote_scope => base_vote_config.id).size*top
    if denominator == 0
      0.0
    else
      numerator.to_f/denominator.to_f*100.0
    end
  end
end
