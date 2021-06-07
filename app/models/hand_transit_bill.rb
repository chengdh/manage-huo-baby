# -*- encoding : utf-8 -*-
#手工中转运单
class HandTransitBill < CarryingBill

  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "OutterTransitReturnBill"

  validate :check_goods_no
  validates_presence_of :transit_org_id,:area_id,:bill_no,:goods_no
  #手工运单,编号从0 ～ 3999999
  validates_inclusion_of :bill_no,:in => '0000000'..'3999999'
  #验证货号格式
  validate :check_goods_no
  #验证中转运费和中转手续费不可大运运费
  validate :check_transit_fee

  #重写pay_types
  def self.pay_types
      ret = ActiveSupport::OrderedHash.new
      ret["提货付"] = PAY_TYPE_TH
      ret["现金付"] = PAY_TYPE_CASH
      ret
  end

  #默认货号
  default_value_for :goods_no do
    Date.today.strftime('%y%m%d')
  end

  #手工运单验证货号与发货地和收货地是否匹配
  def check_goods_no
    errors.add(:goods_no,"与发货地或中转地不匹配.") unless self.goods_no.include?("#{self.from_org.try(:simp_name)}#{self.transit_org.try(:simp_name)}")
  end
  #override 提货应收费用
  #中转票计算时 现付时 不扣中转运费
  def th_amount
      amount = self.carrying_fee_th - self.transit_hand_fee - self.transit_carrying_fee + self.goods_fee + self.insured_fee_th + self.from_short_carrying_fee_th + self.to_short_carrying_fee_th + self.manage_fee_th
      amount += transit_carrying_fee if pay_type.eql?(CarryingBillExtend::PayType::PAY_TYPE_CASH)
      amount
  end
  #生成退货单
  #中转原货退回时，提付生成双倍运费，票据显示中转费也双倍；现付票原货退货时，运费、中转费单倍；
  def generate_return_bill
    override_attr = {
      "bill_no" => "TH#{bill_no}",
      "bill_date"=> Date.today,
      "from_org_id"=> transit_org_id,
      "to_org_id"=> from_org_id,
      "from_customer_name"=> to_customer_name,
      "from_customer_phone"=> to_customer_phone,
      "from_customer_mobile"=> to_customer_mobile,
      "to_customer_name"=> from_customer_name,
      "to_customer_phone"=> from_customer_phone,
      "to_customer_mobile"=> from_customer_mobile,
      "from_customer_id"=> nil,
      "to_customer_id"=> nil,
      "pay_type"=> CarryingBillExtend::PayType::PAY_TYPE_TH,
      "goods_fee"=> 0,
      "manage_fee"=> 0,
      "transit_carrying_fee" => (pay_type == CarryingBillExtend::PayType::PAY_TYPE_CASH ? transit_carrying_fee.to_i : transit_carrying_fee.to_i*2),
      "insured_fee" => 0,
      "from_short_carrying_fee" => (pay_type == CarryingBillExtend::PayType::PAY_TYPE_CASH ? to_short_carrying_fee.to_i : to_short_carrying_fee.to_i*2),
      "to_short_carrying_fee" => (pay_type == CarryingBillExtend::PayType::PAY_TYPE_CASH ? from_short_carrying_fee.to_i : from_short_carrying_fee.to_i*2),
      "carrying_fee_1st" => (pay_type == CarryingBillExtend::PayType::PAY_TYPE_CASH ? carrying_fee_2st.to_i : carrying_fee_2st.to_i*2),
      "carrying_fee_2st" => (pay_type == CarryingBillExtend::PayType::PAY_TYPE_CASH ? carrying_fee_1st.to_i : carrying_fee_1st.to_i*2),
      "carrying_fee"=> (pay_type == CarryingBillExtend::PayType::PAY_TYPE_CASH ? carrying_fee.to_i : 2*carrying_fee.to_i),
      "note"=> "原运单票据号:#{bill_no},货号:#{goods_no},运费:#{carrying_fee},代收货款;#{goods_fee}"
    }
    return_attr = attributes.merge(override_attr)
    delete_attrs = %w[goods_no original_carrying_fee original_goods_fee original_from_short_carrying_fee insured_rate original_insured_amount type original_insured_fee id original_to_short_carrying_fee original_carrying_fee]
    return_attr.delete_if { |key,value| delete_attrs.include?(key)}
    build_return_bill(return_attr)
  end
end

