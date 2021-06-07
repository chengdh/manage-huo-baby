#coding: utf-8
#预付款凭证
class PrepayEntry < ActiveRecord::Base
  belongs_to :org
  attr_accessible :balance, :bill_date, :credit, :debit, :note, :entry_type,:org_id,:org
  validates :bill_date,:org_id, :presence => true

  default_value_for :bill_date do
    Date.today
  end

  #获取最后余额
  def self.last_entry(org_id)
    create_beginning_entry(org_id)
    self.where(:org_id => org_id).last
  end
  #发货时,生成预付款凭据
  def self.create_from_load_list(load_list)
    #NOTE 不处理中转业务
    return if load_list.transit_org_id.present?

    sum_goods_fee = load_list.carrying_bills.sum(:goods_fee)
    sum_fee = load_list.carrying_bills.sum_by_pay_type_th
    #借方金额（debit) = 运费 + 货款 + 保险费 + 短途运费
    #贷方金额(credit) = 0
    #余额 =  贷方 - 借方 + 上次余额
    #20151010  不再包含到货短途费
    #sum_credit = sum_goods_fee + sum_fee[0].sum_insured_fee + sum_fee[0].sum_carrying_fee + sum_fee[0].sum_from_short_carrying_fee + sum_fee[0].sum_to_short_carrying_fee
    sum_credit = sum_goods_fee + sum_fee[0].sum_insured_fee + sum_fee[0].sum_carrying_fee + sum_fee[0].sum_from_short_carrying_fee

    #获取余额
    last_prepay_entry = last_entry(load_list.to_org_id)

    last_balance = last_prepay_entry.balance
    sum_balance = last_balance + sum_credit
    create!(:org => load_list.to_org,:credit => sum_credit,:balance => sum_balance,:note => "#{load_list.bill_no}-货运单")
  end
  #收款确认时,生成预付款清单
  def self.create_from_refund(refund)
    #NOTE 不处理中转业务
    return if refund.transit_org_id.present?

    sum_goods_fee = refund.carrying_bills.sum(:goods_fee)
    sum_fee = refund.carrying_bills.sum_by_pay_type_th
    #借方金额（debit) = 运费 + 货款 + 保险费 + 短途运费
    #贷方金额 (credit) = 0
    #余额 =  贷方 - 借方 + 上次余额
    #20151010  不再包含到货短途费
    #sum_debit = sum_goods_fee + sum_fee[0].sum_insured_fee + sum_fee[0].sum_carrying_fee + sum_fee[0].sum_from_short_carrying_fee + sum_fee[0].sum_to_short_carrying_fee
    sum_debit = sum_goods_fee + sum_fee[0].sum_insured_fee + sum_fee[0].sum_carrying_fee + sum_fee[0].sum_from_short_carrying_fee

    #获取余额
    last_prepay_entry = last_entry(refund.from_org_id)

    last_balance = last_prepay_entry.balance
    sum_balance = last_balance - sum_debit
    create!(:org => refund.from_org,:debit => sum_debit,:balance => sum_balance,:note => "#{refund.bill_date}-返款单")
  end


  #NOTE 调整期初余额
  #因期初余额是业务操作发生后生成的,因此第一次生成期初余额时,需要根据不同的业务情况做调整
  #第一次生成期初余额时,依据不同的业务,期初余额会比实际多或少得情况
  #1 自返款清单生成 期初余额比实际少,因生成返款清单时,运单状态已改变,但是期初余额生成在返款单生成之后,所以期初余额 = 原值 + 返款单合计金额
  #2 自货物运输清单生成 期初余额比实际多,因生成货物装车清单时,运单状态已改变,但是期初余额生成在货物运输单生成之后,所以期初余额 = 原值 - 货物运输清单合计金额
  #3 运单重置、注销、货款变化、支付方式变化、运费、发货短途变化,期初余额比实际的少,期初余额 = 原值 + 变化金额
  def adjust_beginning_balance(adjust_fee)
    update_attributes(:credit => credit + adjust_fee,:balance => balance + adjust_fee) if entry_type == 0
  end
  #生成期初余额
  #计算方法,计算该机构所有未提货票据的运费(提付)+货款合计
  private
  def self.create_beginning_entry(org_id)
    unless exists?(:org_id => org_id,:entry_type => 0)
      #期初数显示在贷方金额中
      #借方 = 0
      #余额 =  贷方 - 借方
      sum_fee = CarryingBill.prepay_entry_beginning_balance(org_id)

      #计算提货付费用合计
      sum_fee_th = CarryingBill.where(:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH).prepay_entry_beginning_balance(org_id)

      #beginning_credit = sum_fee[0].sum_goods_fee + sum_fee_th[0].sum_insured_fee + sum_fee_th[0].sum_carrying_fee + sum_fee_th[0].sum_from_short_carrying_fee + sum_fee_th[0].sum_to_short_carrying_fee
      beginning_credit = sum_fee[0].sum_goods_fee + sum_fee_th[0].sum_insured_fee + sum_fee_th[0].sum_carrying_fee + sum_fee_th[0].sum_from_short_carrying_fee
      self.create!(:org_id => org_id,:credit => beginning_credit,:note => "期初",:balance => beginning_credit,:entry_type => 0)
    end
  end
end
