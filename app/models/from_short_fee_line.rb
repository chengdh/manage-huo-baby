#coding: utf-8
class FromShortFeeLine < ActiveRecord::Base
  belongs_to :from_short_fee_info
  belongs_to :carrying_bill

  #已提货票据
  scope :after_deliveried,lambda{joins(:carrying_bill).where("carrying_bills.state in  ('deliveried','settlemented','refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted')")}

  #未提货票据
  scope :before_deliveried,lambda{ joins(:carrying_bill).where("carrying_bills.state in  ('billed','sorted_in','loaded_in','loaded','shipped','transit_reached','transit_shipped','reached','distributed','transited')")}

  scope :bills_weather_deliveried,lambda{|v| joins(:carrying_bill).where("carrying_bills.state in  (#{get_bill_states(v)})")}
  search_methods :before_deliveried,:after_deliveried,:bills_weather_deliveried

  #获取运单状态
  def self.get_bill_states(a_arg)
    deliveried = ['deliveried','settlemented','refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted']
    no_deliveried = ['billed','sorted_in','loaded_in','loaded','shipped','transit_reached','transit_shipped','reached','distributed','transited']
    ret = nil
    ret = deliveried + no_deliverid if a_arg.blank?
    ret = deliveried if a_arg.eql?('deliveried')
    ret = no_deliveried if a_arg.eql?('no_deliveried')
    "'#{ret.join("','")}'"
  end

  def goods_fee
    carrying_bill.goods_fee
  end

  def carrying_fee
    carrying_bill.carrying_fee
  end

  def from_short_carrying_fee
    carrying_bill.from_short_carrying_fee
  end
end
