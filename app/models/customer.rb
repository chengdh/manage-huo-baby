#coding: utf-8
class Customer < ActiveRecord::Base
  default_value_for :vip_state,'draft'
end
