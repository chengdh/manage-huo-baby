# -*- encoding : utf-8 -*-
require 'calculate_hand_fee'
class ConfigCash < ActiveRecord::Base
  include CalculateHandfee
  belongs_to :org
  belongs_to :to_org,:class_name => "Org"
  validates :fee_from,:fee_to,:hand_fee,:numericality => true
  validates :rate,:numericality => {:greater_than_or_equal_to => 0}
end

