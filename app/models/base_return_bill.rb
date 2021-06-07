#coding: utf-8
#退货单基础类
class BaseReturnBill < CarryingBill
  before_validation :generate_goods_no
  validates_presence_of :to_org_id

  #根据原始运单生成退货单
  def self.new_with_ori_bill(ori_bill)
    bill = ori_bill.generate_return_bill
    bill
  end
end
