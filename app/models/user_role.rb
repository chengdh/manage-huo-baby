# -*- encoding : utf-8 -*-
#coding: utf-8
class  UserRole < ActiveRecord::Base
  belongs_to :user,:touch => true
  belongs_to :role
end

