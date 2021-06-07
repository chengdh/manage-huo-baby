# -*- encoding : utf-8 -*-
#coding: utf-8
module BanksHelper
  def banks_for_select
    Bank.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.code})",b.id]}
  end

  def bank_names_for_select
    Bank.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.code})",b.name]}
  end
end

