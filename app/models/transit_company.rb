# -*- encoding : utf-8 -*-
#coding: utf-8
class TransitCompany < ActiveRecord::Base
  validates_presence_of :name 
  def to_s
    self.name
  end
end

