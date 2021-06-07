# -*- encoding : utf-8 -*-
#coding: utf-8
class BanksController < BaseController
  table :except => [:created_at,:updated_at]
end
