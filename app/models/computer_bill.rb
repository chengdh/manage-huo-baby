# -*- encoding : utf-8 -*-
#机打票
class ComputerBill < CarryingBill
  before_validation :generate_bill_no,:on => :create
  #创建/修改数据前生成票据编号和货号
  before_validation :generate_goods_no
  #更新数据时,验证运单号/货号不可为空
  validates :bill_no,:goods_no,:to_org_id,:presence => true

  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "ReturnBill"
end
