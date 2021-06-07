#coding: utf-8
#同城快运-货款支付清单(现金)
class LocalTownCashPaymentList < PaymentList
  attr_protected :bank_id
  validates :org_id,:presence => true

  #定义状态机
  state_machine :initial => :billed do
    after_transition do |payment_list,transition|
      payment_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:payment_listed
    end
  end
  # 应根据需要设置短信提醒文本
  #生成短信通知文本信息
  def export_sms_txt
    #去除固定电话
    sms_bills = self.carrying_bills.find_all {|bill| bill.sms_mobile_for_sender.present? and bill.goods_fee > 0 }
    no_mobile_sms_bills = self.carrying_bills.find_all {|bill| bill.sms_mobile_for_sender.blank? and bill.goods_fee > 0 }
    group_sms_bills = sms_bills.group_by(&:sms_mobile_for_sender)
    #分别合计货物件数/运费合计/货款合计
    sms_text = ''
    group_sms_bills.each do |key,bills|
      goods_num = bills.to_a.sum(&:goods_num)
      carrying_fee_th = 0.0
      bill_nos = []
      bills.each do |the_bill|
        carrying_fee_th += the_bill.carrying_fee if the_bill.pay_type.eql?(CarryingBill::PAY_TYPE_TH)
        bill_nos << the_bill.bill_no
      end
      #goods_fee = bills.to_a.sum(&:goods_fee).try(:to_i)
      sms_text += Settings.notice_cash_payment_list.sms_batch % [key,bill_nos.join(" ")]
    end
    #加一个空行
    sms_text +="===============================以下运单无手机号===============================================\r\n"
    no_mobile_sms_bills.each do |bill|
      sms_text += Settings.notice_cash_payment_list.sms_batch % [bill.try(:phone_or_mobile_for_sender),bill.bill_no]
    end

    sms_text
  end

  # attr_accessible :title, :body
end
