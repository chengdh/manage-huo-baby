# -*- encoding : utf-8 -*-
#coding: utf-8
class Bank < ActiveRecord::Base
  validates :name,:code,:presence => true
  validates :code,:uniqueness => true
  def to_s
    self.name
  end
end

