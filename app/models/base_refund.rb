#coding: utf-8
#返款清单基类
class BaseRefund < ActiveRecord::Base
  self.table_name = "refounds"
  belongs_to :user

  #FIXME rails3.1 BUG #6978 如果对象是new_record,在执行association finder和where/sum等函数时,会产生错误的sql语句
  has_many :carrying_bills,:foreign_key => "refound_id",:order => "goods_no ASC",:conditions => "refound_id IS NOT NULL"

  belongs_to :from_org,:class_name => "Org"
  belongs_to :transit_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  has_one :remittance,:foreign_key => "refound_id"
  validates_presence_of :bill_date,:from_org_id,:to_org_id

  #待确认付款清单
  scope :refunded,lambda {|to_org_ids| select("sum(1) as bill_count").where(:state => :refunded,:to_org_id => to_org_ids)} #发货地查看中转清单
  scope :from_org_refunds,lambda {|org_ids| where(["from_org_id in (#{org_ids.join(',')}) AND transit_org_id IS NOT NULL"])}
  #中转地查看中转运单
  scope :transit_org_refunds,lambda {|org_ids| where(["state in ('refunded','transit_refunded_confirmed','refunded_confirmed') AND transit_org_id in (#{org_ids.join(',')})"])}
  #到货地
  scope :to_org_refunds,lambda {|org_ids| where(["state in ('transit_refunded_confirmed','refunded_confirmed') AND to_org_id in (#{org_ids.join(',')}) AND transit_org_id IS NOT NULL"])}

  #定义状态机
  state_machine :initial => :billed do
    after_transition do |refound,transition|
      refound.carrying_bills.each {|bill| bill.standard_process}
    end
    #生成付款单后,生成预付款凭证-期初
    before_transition :billed => :refunded do |refund,transition|
      PrepayEntry.last_entry(refund.from_org_id) if refund.valid?
    end

    after_transition :billed => :refunded do |refund,transition|
      PrepayEntry.create_from_refund(refund) if refund.valid?
    end

    event :process do
      transition :billed =>:refunded
      transition :refunded => :refunded_confirmed,:if => lambda {|bill| bill.transit_org_id.blank?}
      transition :refunded => :transit_refunded_confirmed,
        :transit_refunded_confirmed => :refunded_confirmed,
        :if => lambda {|bill| bill.transit_org_id.present?}
    end
  end

  default_value_for :bill_date do
    Date.today
  end
  #提付运费合计,含提付保价费
  def sum_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:carrying_fee)
  end
  def sum_insured_fee_th
    carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:insured_fee)
  end
  #合计管理费
  def sum_manage_fee_th
    carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:manage_fee)
  end

  #FIXME 20150929 返款时不返到货短途
  def sum_carrying_fee_th_total
    sum_carrying_fee_th + sum_manage_fee_th + sum_from_short_carrying_fee_th + sum_to_short_carrying_fee_th
  end
  def sum_transit_hand_fee
    carrying_bills.sum(:transit_hand_fee)
  end
  def sum_transit_carrying_fee
    carrying_bills.sum(:transit_carrying_fee)
  end
  #提付中转费
  def sum_transit_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:transit_carrying_fee)
  end

  def sum_goods_fee
    carrying_bills.sum(:goods_fee) - sum_goods_fee_qr_pay
  end
  def sum_from_short_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:from_short_carrying_fee)
  end
  def sum_to_short_carrying_fee_th
    carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:to_short_carrying_fee)
  end

  def sum_th_amount
    sum_goods_fee + sum_carrying_fee_th_total + sum_insured_fee_th - sum_transit_hand_fee - sum_transit_carrying_fee_th +  sum_k_hand_fee_qr_pay
  end
  #前段付运费合计
  def sum_carrying_fee_1st
    carrying_bills.sum(:carrying_fee_1st)
  end
  #后段付运费合计
  def sum_carrying_fee_2st
    carrying_bills.sum(:carrying_fee_2st)
  end

 def qy_pay_from_customer_ids
    customer_ids = carrying_bills.pluck(:from_customer_id).compact
    customer_ids.uniq!
    #筛选出二维码支付客户
    qr_customer_ids = Vip.where(:id => customer_ids,:is_qrcode_pay => true).pluck(:id)
  end

  def sum_goods_fee_qr_pay
    qr_customer_ids = qy_pay_from_customer_ids()
    carrying_bills.where(:from_customer_id => qr_customer_ids).sum(:goods_fee)
  end

  def sum_k_hand_fee_qr_pay
    qr_customer_ids = qy_pay_from_customer_ids()
    carrying_bills.where(:from_customer_id => qr_customer_ids).sum(:k_hand_fee)
  end


  #导出到csv
  def to_csv
    ret = ["返款日期:",self.bill_date,"付款单位:",self.from_org.name,"收款单位:",self.to_org.name,"结算员:",self.user.try(:username)].export_line_csv(true)
    ret = ret + ["提付运费:",self.sum_carrying_fee_th_total,"代收货款:",self.sum_goods_fee,"合计:",self.sum_th_amount].export_line_csv
    ret = ret + ["备注:",self.note,"状态",self.human_state_name ].export_line_csv
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,Refound.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  private
  def self.carrying_bill_export_options
    {
        :only => [],
        :methods => [
          :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :to_customer_name,:to_customer_phone,:to_customer_mobile,
          :pay_type_des,
          :carrying_fee_th,:goods_fee,:insured_fee,
          :note,:human_state_name
      ]}
  end
end
