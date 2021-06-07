#coding: utf-8
#分成报表-宇玖
class DivideRptYujiu < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  belongs_to :confirm_user,:class_name => "User"
  validates :org_id,:user_id, :presence => true
  default_scope order("mth DESC")

  state_machine :initial => :draft do
    after_transition :saved => :confirmed do |info,transition|
      #更新核销时间
      info.update_attributes(:confirm_datetime => Time.now)
    end
    event :process do
      transition :draft => :saved,:saved => :confirmed
    end
  end

  default_value_for :bill_date do
    Date.today
  end

  default_value_for :mth do
    1.months.ago.strftime("%Y%m")
  end

  #合计分成金额
  def sum_divide_fee
    divide_carrying_fee_from + divide_carrying_fee_to +
      divide_inner_transit_carrying_fee_from + divide_inner_transit_carrying_fee_to +
      divide_outter_transit_carrying_fee_from
  end

  #合计应补费用
  def sum_plus_fee
    plus_fee_1 + plus_fee_2 + plus_fee_3 + plus_fee_4 + plus_fee_5 + plus_fee_6 +
      plus_fee_7 + plus_fee_8 + plus_fee_9 + plus_fee_10
  end

  #合计应扣
  def sum_deduct_fee
    deduct_fee_1 + deduct_fee_2 + deduct_fee_3 + deduct_fee_4 + deduct_fee_5 + deduct_fee_6 +
      deduct_fee_7 + deduct_fee_8 + deduct_fee_9 + deduct_fee_10
  end

  #合计其他应扣
  def sum_other_deduct_fee
    other_deduct_fee_1 + other_deduct_fee_2 + other_deduct_fee_3 + other_deduct_fee_4 + other_deduct_fee_5 + other_deduct_fee_6 +
      other_deduct_fee_7 + other_deduct_fee_8 + other_deduct_fee_9 + other_deduct_fee_10
  end

  #合计费用
  def sum_fee
    sum_divide_fee + sum_plus_fee - sum_deduct_fee - sum_other_deduct_fee
  end


  #生成分成报表
  def self.generate_divide_rpt_yujiu(org_id,mth)
    date_from = "#{mth[0,4]}-#{mth[4,5]}-01"
    date_to = "#{mth[0,4]}-#{mth[4,5]}-31"
    divide_config = DivideConfigYujiu.where(:org_id => org_id,:is_active => true).first
    divide_config = DivideConfigYujiu.new if divide_config.blank?
    #始发货收入
    divide_bills_from = CarryingBill.divide_bills_from(org_id,date_from,date_to).try(:first)
    carrying_fee_from = divide_bills_from.try(:sum_carrying_fee).to_i
    rate_carrying_fee_from = divide_config.rate_from
    divide_fee_from = carrying_fee_from  * rate_carrying_fee_from


    #始发货月结收入
    divide_bills_from_re = CarryingBill.divide_bills_from_re(org_id,date_from,date_to).try(:first)
    carrying_fee_from_re = divide_bills_from_re.try(:sum_carrying_fee).to_i
    divide_fee_from_re = carrying_fee_from_re  * rate_carrying_fee_from

    #返程货收入
    divide_bills_to = CarryingBill.divide_bills_to(org_id,date_from,date_to).try(:first)
    carrying_fee_to = divide_bills_to.try(:sum_carrying_fee).to_i
    rate_carrying_fee_to = divide_config.rate_to
    divide_fee_to = carrying_fee_to * rate_carrying_fee_to


    #返程货月结收入
    divide_bills_to_re = CarryingBill.divide_bills_to_re(org_id,date_from,date_to).try(:first)
    carrying_fee_to_re = divide_bills_to_re.try(:sum_carrying_fee).to_i
    divide_fee_to_re = carrying_fee_to_re * rate_carrying_fee_to


    divide_fee_to_re = divide_bills_to_re.try(:sum_carrying_fee).to_i * divide_config.rate_to

    #内部中转始发收入
    divide_inner_transit_bills_from = CarryingBill.divide_inner_transit_bills_from(org_id,date_from,date_to).try(:first)
    carrying_fee_inner_transit_from = divide_inner_transit_bills_from.try(:sum_carrying_fee).to_i
    rate_inner_transit_from = divide_config.rate_inner_transit_from
    divide_fee_inner_transit_from = carrying_fee_inner_transit_from * rate_inner_transit_from

    #内部中转月结始发收入
    divide_inner_transit_bills_from_re = CarryingBill.divide_inner_transit_bills_from_re(org_id,date_from,date_to).try(:first)

    carrying_fee_inner_transit_from_re = divide_inner_transit_bills_from_re.try(:sum_carrying_fee).to_i
    rate_inner_transit_from = divide_config.rate_inner_transit_from
    divide_fee_inner_transit_from_re = carrying_fee_inner_transit_from_re * rate_inner_transit_from 

    #内部中转返程收入
    divide_inner_transit_bills_to = CarryingBill.divide_inner_transit_bills_to(org_id,date_from,date_to).try(:first)

    carrying_fee_inner_transit_to = divide_inner_transit_bills_to.try(:sum_carrying_fee).to_i
    rate_inner_transit_to = divide_config.rate_inner_transit_to
    divide_fee_inner_transit_to = carrying_fee_inner_transit_to * rate_inner_transit_to


    #内部中转月结返程收入
    divide_inner_transit_bills_to_re = CarryingBill.divide_inner_transit_bills_to_re(org_id,date_from,date_to).try(:first)

    carrying_fee_inner_transit_to_re = divide_inner_transit_bills_to_re.try(:sum_carrying_fee).to_i
    rate_inner_transit_to = divide_config.rate_inner_transit_to
    divide_fee_inner_transit_to_re = carrying_fee_inner_transit_to_re * rate_inner_transit_to


    #外部中转分成
    divide_outter_transit_bills_from = CarryingBill.divide_outter_transit_bills_from(org_id,date_from,date_to).try(:first)

    carrying_fee_outter_transit_from = divide_outter_transit_bills_from.try(:sum_carrying_fee).to_i
    rate_outter_transit_from = divide_config.rate_outter_transit_from
    divide_fee_outter_transit_from = carrying_fee_outter_transit_from * rate_outter_transit_from

    divide_rpt_yujiu = DivideRptYujiu.new(:org_id => org_id,
                                         :mth => mth,
                                         :carrying_fee_from => carrying_fee_from + carrying_fee_from_re,
                                         :rate_carrying_fee_from => rate_carrying_fee_from,
                                         :divide_carrying_fee_from => divide_fee_from + divide_fee_from_re,
                                         :carrying_fee_to => carrying_fee_to + carrying_fee_to_re,
                                         :rate_carrying_fee_to => rate_carrying_fee_to,
                                         :divide_carrying_fee_to => divide_fee_to + divide_fee_to_re,
                                         :inner_transit_carrying_fee_from => carrying_fee_inner_transit_from + carrying_fee_inner_transit_from_re,
                                         :rate_inner_transit_carrying_fee_from => rate_inner_transit_from,
                                         :divide_inner_transit_carrying_fee_from => divide_fee_inner_transit_from + divide_fee_inner_transit_from_re,
                                         :inner_transit_carrying_fee_to => carrying_fee_inner_transit_to + carrying_fee_inner_transit_to_re,
                                         :rate_inner_transit_carrying_fee_to  => rate_inner_transit_to,
                                         :divide_inner_transit_carrying_fee_to => divide_fee_inner_transit_to + divide_fee_inner_transit_to_re,
                                         :outter_transit_carrying_fee_from => carrying_fee_outter_transit_from,
                                         :rate_outter_transit_carrying_fee_from => rate_outter_transit_from,
                                         :divide_outter_transit_carrying_fee_from => divide_fee_outter_transit_from
                                         )

    divide_rpt_yujiu
  end
end
