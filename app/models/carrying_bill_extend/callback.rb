# -*- encoding : utf-8 -*-
#运单callback定义相关
module CarryingBillExtend
  module Callback
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        #before_validation :set_customer
        #保存成功后,设置原始费用
        before_create :set_original_fee
        #计算手续费
        #NOTE 当修改单据的代收货款时，也重新计算运费
        before_save :cal_hand_fee
      end
    end
    private
    #instance methods
    #保存票据成功后,设置原始费用
    def set_original_fee
      self.original_carrying_fee = self.carrying_fee
      self.original_from_short_carrying_fee = self.from_short_carrying_fee
      self.original_to_short_carrying_fee = self.to_short_carrying_fee
      self.original_goods_fee = self.goods_fee
      self.original_insured_amount = self.insured_amount
      self.original_insured_fee = self.insured_fee
    end
    #计算手续费
    def cal_hand_fee
      if self.new_record?  or self.changes[:goods_fee].present?
        if self.goods_fee_cash?
          self.k_hand_fee = ConfigCash.cal_hand_fee(:goods_fee => self.goods_fee,:from_org_id => self.from_org_id,:to_org_id => self.to_org_id)
        else
          self.k_hand_fee = ConfigTransit.cal_hand_fee(:goods_fee => self.goods_fee,:from_org_id => self.from_org_id,:to_org_id => self.to_org_id)
        end
      end
      self.k_hand_fee
    end
    #定义类方法
    module ClassMethods ; end
  end
end
