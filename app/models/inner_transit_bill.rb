#coding: utf-8
#内部中转票据
class InnerTransitBill < CarryingBill
  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "InnerTransitReturnBill"

  #创建/修改数据前生成票据编号和货号
  before_validation :generate_bill_no,:on => :create
  before_validation :generate_goods_no
  #更新数据时,验证运单号/货号不可为空
  validates :bill_no,:goods_no,:transit_org_id,:to_org_id,:presence => true
  #重写pay_types
  def self.pay_types
      ret = ActiveSupport::OrderedHash.new
      ret["提货付"] = PAY_TYPE_TH
      ret["现金付"] = PAY_TYPE_CASH
      ret
  end
end
