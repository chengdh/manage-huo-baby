# -*- encoding : utf-8 -*-
#客户提款结算清单
class GoodsFeeSettlementList < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  belongs_to :post_info,:class_name => "BasePostInfo"
  validates_presence_of :org_id,:post_info_id
  validates_numericality_of :amount_goods_fee,:amount_hand_fee,:amount_k_carrying_fee,:amount_bills
  validates :amount_fee,:numericality => {:greater_than => 0},:on => :update
  default_value_for :bill_date do
    Date.today
  end

  #定义状态机
  state_machine :initial => :draft do
    event :post do
      transition :draft =>:posted
    end
  end
  #以下定义虚拟属性
  #统计货款
  def amount_goods_fee_auto
    self.post_info.try(:sum_goods_fee).to_f
  end
  #统计扣运费
  def amount_k_carrying_fee_auto
    self.post_info.try(:sum_k_carrying_fee).to_f
  end
  #统计手续费
  def amount_hand_fee_auto
    self.post_info.try(:sum_k_hand_fee).to_f
  end
  #扣保险费
  def amount_k_insured_fee_auto
    self.post_info.try(:sum_k_insured_fee).to_f
  end
  #扣发货短途
  def amount_k_from_short_carrying_fee_auto
    self.post_info.try(:sum_k_from_short_carrying_fee).to_f
  end
  #扣到货短途
  def amount_k_to_short_carrying_fee_auto
    self.post_info.try(:sum_k_to_short_carrying_fee).to_f
  end

  #统计票据数
  def amount_bills_auto
    self.post_info.try(:carrying_bills).try(:size).to_i
  end
  #票据数合计
  def sum_bills
    self.amount_bills_auto + self.amount_bills.to_i
  end
  #收入总计
  #收入=手续费+货款扣运费+ 扣保险费 + 扣发货短途 + 扣到货短途 + 实领金额
  def sum_income_fee
    self.amount_hand_fee + self.amount_hand_fee_auto  + self.amount_k_carrying_fee_auto + self.amount_k_carrying_fee +  self.amount_k_insured_fee_auto + self.amount_k_insured_fee + self.amount_k_from_short_carrying_fee_auto + self.amount_k_from_short_carrying_fee + self.amount_k_to_short_carrying_fee + self.amount_k_to_short_carrying_fee_auto + self.amount_fee
  end
  #支出合计
  def sum_spending_fee
    self.amount_goods_fee_auto + self.amount_goods_fee
  end
  #余额
  #余额 = 收入 - 支出
  def sum_rest_fee
    self.sum_income_fee - self.sum_spending_fee
  end
end

