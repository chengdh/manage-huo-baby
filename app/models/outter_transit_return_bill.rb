#coding: utf-8
#外部中转-退货单
class OutterTransitReturnBill < BaseReturnBill
  #override 提货应收费用
  #中转退货票计算时提货应收不去除中转相关费用
  def th_amount
    amount = self.carrying_fee_th + self.goods_fee + self.insured_fee_th + self.from_short_carrying_fee_th + self.to_short_carrying_fee_th + self.manage_fee_th
    amount
  end
end
