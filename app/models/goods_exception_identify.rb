#coding: utf-8
class GoodsExceptionIdentify < ActiveRecord::Base
  belongs_to :goods_exception
  belongs_to :user
  default_value_for :bill_date do
    Date.today
  end
end

