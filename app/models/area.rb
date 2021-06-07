# -*- encoding : utf-8 -*-
class Area < ActiveRecord::Base
  validates_presence_of :name
  def to_s
    self.name
  end
end
