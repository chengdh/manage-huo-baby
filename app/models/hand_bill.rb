# -*- encoding : utf-8 -*-
#手工运单
class HandBill < CarryingBill

  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "ReturnBill"


  #validates :bill_no,:goods_no,:uniqueness => true

  validate :check_goods_no
  validates_presence_of :to_org_id,:bill_no,:goods_no
  #手工运单,编号从0 ～ 3999999
  #validates_inclusion_of :bill_no,:in => '0000000'..'3999999'
  validates_inclusion_of :bill_no,:in => '0000000'..'9250000'
  #默认货号
  default_value_for :goods_no do
    Date.today.strftime('%y%m%d')
  end
  private
  #手工运单验证货号与发货地和收货地是否匹配
  def check_goods_no
    errors.add(:goods_no,"与发货地或收货地不匹配.") unless self.goods_no.include?("#{self.from_org.try(:simp_name)}#{self.to_org.try(:simp_name)}")
  end
end
