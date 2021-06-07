#coding: utf-8
class ShortFeeConfig < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  validates :name,:from_org_id,:to_org_id,:operator, presence: true
  validates :short_fee_rate,:fixed_short_fee, numericality: true
  validates :operator,inclusion: %w(gt gte lt lte eq)
  validates :carrying_fee,numericality: {greater_than: 0}

  def self.operates
    {
      "小于等于" => "lte","小于" => "lt" ,"大于" => "gt","大于等于" => "gte" , "等于" => "eq"
    }
  end
end
