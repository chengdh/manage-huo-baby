# -*- encoding : utf-8 -*-
#coding: utf-8
class Sender < ActiveRecord::Base
  belongs_to :org
  validates_presence_of :name,:id_number
  def to_s
    self.name
  end
end

