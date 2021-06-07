# -*- encoding : utf-8 -*-
#coding: utf-8
class SystemFunctionGroup < ActiveRecord::Base
  has_many :system_functions,:include => :system_function_operates
  default_scope :include => :system_functions
end

