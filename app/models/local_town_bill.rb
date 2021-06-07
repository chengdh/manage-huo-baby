#coding: utf-8
#同城配送运单
class LocalTownBill < CarryingBill
  #创建/修改数据前生成票据编号和货号
  before_validation :generate_goods_no
  before_validation :generate_bill_no,:on => :create
  #更新数据时,验证运单号/货号不可为空
  validates :bill_no,:goods_no,:to_org_id,:presence => true

  #TODO 对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "LocalTownReturnBill"

  default_value_for :insured_fee,0
  default_value_for :manage_fee,0

  #重写pay_types
  def self.pay_types
      ret = ActiveSupport::OrderedHash.new
      ret["提货付"] = PAY_TYPE_TH
      ret["现金付"] = PAY_TYPE_CASH
      ret
  end
  private
  def generate_bill_no
    self.bill_no = "T" + BillNo.gen_bill_no.to_s
  end
end
