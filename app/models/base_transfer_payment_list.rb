#coding: utf-8
#转账支付清单基类
class BaseTransferPaymentList < PaymentList
  validates_presence_of :bank_id
  validates_associated :carrying_bills
  #定义状态机
  state_machine :initial => :billed do
    #NOTE 转账确认操作时,不改变运单状态
    after_transition :billed => :payment_listed do |payment_list,transition|
      payment_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      #流程 草稿 -- 清单已列 -- 已转账
      transition :billed =>:payment_listed,:payment_listed => :transfered
    end
  end


  #导出为建行转账格式文本
  def ccb_to_txt
    ret = ''
    self.carrying_bills.each_with_index do |bill,index|
      ret += [index + 1,1,bill.from_customer.bank_card,bill.from_customer.name,'|建行',bill.act_pay_fee,'货款',0].join('|') + "|\r\n"
    end
    ret
  end
  #导出为兴业转账格式文本
  def cib_to_txt
    ret = ''
    self.carrying_bills.each_with_index do |bill,index|
      ret += ['nb40',index + 1,0,bill.from_customer.bank_card,bill.from_customer.name,'兴业银行','|||',"#{bill.act_pay_fee}","宇玖#{bill.bill_no}"].join('|') + "|\r\n"
    end
    ret
  end

  def self.carrying_bill_export_options
    {
      :only => [],
      :methods => [
        :bill_no,:act_pay_fee,:from_customer_bank_card,:from_customer_name,:from_customer_code,:from_customer_bank_name,:goods_fee,:k_hand_fee,:k_carrying_fee,:goods_no
      ]}
  end

  # attr_accessible :title, :body
end
