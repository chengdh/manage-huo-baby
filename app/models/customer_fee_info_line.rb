# -*- encoding : utf-8 -*-
#coding: utf-8
class CustomerFeeInfoLine < ActiveRecord::Base
  belongs_to :customer_fee_info
  validates_presence_of :name
end

