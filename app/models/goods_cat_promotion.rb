#coding: utf-8
class GoodsCatPromotion < ActiveRecord::Base
  belongs_to :goods_cat,:touch => true
  validates :from_fee,:to_fee,:promotion_rate,:numericality => true
end
