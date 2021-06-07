#coding: utf-8
#手工内部中转运单
class HandInnerTransitBill < CarryingBill

  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "InnerTransitReturnBill"

  validate :check_goods_no

  validates_presence_of :to_org_id,:bill_no,:goods_no
  #手工运单,编号从0 ～ 3999999
  validates_inclusion_of :bill_no,:in => '0000000'..'3999999'
    #默认货号
  default_value_for :goods_no do
    Date.today.strftime('%y%m%d')
  end
  #重写pay_types
  def self.pay_types
      ret = ActiveSupport::OrderedHash.new
      ret["提货付"] = PAY_TYPE_TH
      ret["现金付"] = PAY_TYPE_CASH
      ret
  end

  private
  #手工运单验证货号与发货地和收货地是否匹配
  def check_goods_no
    errors.add(:goods_no,"与发货地或收货地不匹配.") unless self.goods_no.include?("#{self.from_org.try(:simp_name)}#{self.to_org.try(:simp_name)}")
  end
end
