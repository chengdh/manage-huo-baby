# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeGoodsExceptionDefaultAction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title("่ดงๆ็่ต")
    sf.update_attributes(:default_action => "goods_exceptions_path('search[state_ni]' => ['identified','posted'])") if sf

  end

  def self.down
  end
end

