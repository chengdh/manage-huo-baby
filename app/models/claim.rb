# -*- encoding : utf-8 -*-
#coding: utf-8
class Claim < ActiveRecord::Base
  belongs_to :user
  belongs_to :goods_exception
  belongs_to :user
  default_value_for :bill_date do
    Date.today
  end

  #validate :check_act_compensate_fee

  private
  def check_act_compensate_fee
    errors.add(:act_compensate_fee, "不能大于拟赔金额") if act_compensate_fee > self.goods_exception.gexception_authorize_info.compensation_fee
  end
end

