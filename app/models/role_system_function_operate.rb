# -*- encoding : utf-8 -*-
#coding: utf-8
class RoleSystemFunctionOperate < ActiveRecord::Base
  belongs_to :role,:touch => true
  belongs_to :system_function_operate,:include => :system_function
end

