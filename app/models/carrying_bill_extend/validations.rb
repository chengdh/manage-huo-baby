# -*- encoding : utf-8 -*-
class CustomerCodeValidator < ActiveModel::EachValidator
  def validate_each(object,attribute,value)
    if value.present?
      from_customer = Vip.find_by_code_and_name_and_is_active(value,object.from_customer_name,true)
      if from_customer.blank?
        object.errors[attribute] <<(options[:message] || "客户编号与姓名不匹配" )
      else
        object.from_customer = from_customer
      end
    else #如果customer_code为null
      object.from_customer = nil
    end
  end
end
module CarryingBillExtend
  module Validations
    def self.included(base)
      base.class_eval do
        #验证运费支付方式为从货款扣时,货款必须大于运费,否则不能保存
        validate :check_k_carrying_fee

        #验证是否需要录入货款
        validate :check_permit_goods_fee

        #验证发货人收货人信息不可乱填写
        validate :check_from_and_to_customer_name,:on => :create

        #运单编号为7位数字
        #TH退货单
        #THT同城退货
        # validates_format_of :bill_no,:with => /^(TH)*\d{7,9}$/,:unless => Proc.new {|bill| ["LocalTownBill","HandLocalTownBill","LocalTownReturnBill"].include?(bill.type)}

        #验证运单号码是否正确
        # validates_format_of :goods_no, :with => /(\d{6})(\p{any}{2,6})(\d{1,10})-(\d{1,10})/
        validates_presence_of :bill_date,:pay_type,:from_customer_name,:to_customer_name,:from_org_id,:goods_info

        #退货单不限制手机号码
        validates_presence_of :from_customer_mobile,:to_customer_mobile,:on => :create,:unless => Proc.new {|bill| bill.type == 'ReturnBill'}

        #不限制电话号码
        # validates_length_of :from_customer_mobile,:to_customer_mobile, :is => 11,:on => :create,:unless => Proc.new {|bill| bill.type == 'ReturnBill'}

        validates_numericality_of :from_customer_mobile,:to_customer_mobile,:on => :create
        validates_numericality_of :insured_fee,:goods_num
        #validates_numericality_of :carrying_fee_1st,:carrying_fee_2st
        validates_numericality_of :goods_fee,:from_short_carrying_fee,:to_short_carrying_fee,:greater_than_or_equal_to => 0,:less_than => 100000
        validates :customer_code,:customer_code => true
        #初始创建运单时,运费必须大于5
        validates :carrying_fee,:numericality => {:greater_than_or_equal_to => 0},:on => :create
        #修改运单时,运费大于或等于0
        validates :carrying_fee,:numericality => {:greater_than_or_equal_to => 0},:on => :update 
        validates :goods_fee,:manage_fee,:insured_fee,:from_short_carrying_fee,:adjust_carrying_fee,
          :to_short_carrying_fee,:carrying_fee_1st,:carrying_fee_2st,:carrying_fee,:numericality => {:only_integer => true},:on => :create

        #validates :bill_no,:goods_no,:uniqueness => true
        validates :bill_no,:uniqueness => true

      end
    end
    #验证中转费用
    def check_transit_fee
      errors.add(:transit_carrying_fee,"中转运费不能大于原运费.") if transit_carrying_fee > carrying_fee
      errors.add(:transit_hand_fee,"中转手续费不能大于原运费.") if transit_hand_fee > carrying_fee
    end
    #运费支付方式为从货款扣时,货款必须大于运费+保险费+手续费
    def check_k_carrying_fee
      errors.add(:k_carrying_fee,"货款金额必须大于运费金额.") if pay_type.eql?(PayType::PAY_TYPE_K_GOODSFEE) and act_pay_fee < 0
    end

    #判断是否限制了代收货款
    def check_permit_goods_fee
      return unless billed?
      if to_org.present? and to_org.limit_goods_fee <=0 and goods_fee > 0
        errors.add(:goods_fee,"不允许开代收货款.")
      end
      if  to_org.present? and to_org.limit_goods_fee > 0 and goods_fee > to_org.limit_goods_fee
        errors.add(:goods_fee,"代收货款限额#{to_org.limit_goods_fee}元.")
      end

    end
    def check_from_and_to_customer_name
      check_dict = %w(无 经理 老板)
      errors.add(:from_customer_name,"发货人信息不可为数字") if /\A[-+]?\d+\z/ === from_customer_name
      errors.add(:to_customer_name,"收货人信息不可为数字") if /\A[-+]?\d+\z/ === from_customer_name

      errors.add(:from_customer_name,"发货人信息不正确") if check_dict.any? { |word| from_customer_name.include?(word) }
      errors.add(:to_customer_name,"收货人信息不正确")  if check_dict.any? { |word| to_customer_name.include?(word) }
    end
  end
end
