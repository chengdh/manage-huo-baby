#coding: utf-8
#base post info class
class BasePostInfo < ActiveRecord::Base
  self.table_name = "post_infos"
  belongs_to :org
  belongs_to :user

  #FIXME rails3.1 BUG #6978 如果对象是new_record,在执行association finder和where/sum等函数时,会产生错误的sql语句
  has_many :carrying_bills,:foreign_key => "post_info_id",:order => "goods_no ASC",:conditions => "post_info_id IS NOT NULL"

  has_many :pay_infos,:through => :carrying_bills,:uniq => true

  validates_presence_of :org_id
  after_create :create_goods_fee_settlement_list

  #定义状态机
  state_machine :initial => :billed do
    after_transition :billed => :posted do |pi,transition|
      pi.carrying_bills.each {|bill| bill.standard_process}
    end
    after_transition :posted => :transfered do |pi,transition|
      pi.transfer_date = Date.today
      pi.save!
    end
    event :process do
      transition :billed =>:posted,:posted => :transfered
    end
  end

  default_value_for :bill_date do
    Date.today
  end
  #运费合计
  def sum_goods_fee
    self.carrying_bills.sum(:goods_fee)
  end
  #扣手续费
  def sum_k_hand_fee
    self.carrying_bills.sum(:k_hand_fee)
  end
  #扣运费
  def sum_k_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee)
  end
  #扣保险费
  def sum_k_insured_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:insured_fee)
  end
  #扣发货短途
  def sum_k_from_short_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:from_short_carrying_fee)
  end
  #扣到货短途
  def sum_k_to_short_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:to_short_carrying_fee)
  end

  #应付合计
  def sum_act_pay_fee
    sum_goods_fee - sum_k_hand_fee - sum_transit_hand_fee - sum_k_carrying_fee - sum_k_insured_fee - sum_k_from_short_carrying_fee - sum_k_to_short_carrying_fee
  end

  #扣中转手续费合计
  def sum_transit_hand_fee
    self.carrying_bills.sum(:transit_hand_fee)
  end
  #余额
  def sum_rest_fee
    amount_fee - sum_act_pay_fee
  end
  #导出到csv
  def to_csv
    ret = ["结算员:",self.user.try(:username),"结算单位:",self.org.name,"结算日期:",self.bill_date].export_line_csv(true)
    ret +=["","","","","实领金额",self.amount_fee].export_line_csv
    ret +=["原货款",self.sum_goods_fee,"扣运费",self.sum_k_carrying_fee,"扣手续费",self.sum_k_hand_fee,"实际提款",self.sum_act_pay_fee].export_line_csv
    ret +=["","","","","余额",self.sum_rest_fee].export_line_csv
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,BasePostInfo.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end

  #批量导出
  def self.batch_to_ccb_txt(ids)
    post_infos = where(:id => ids)
    ret = %w{#序号 付款账户 收款账户 收款账户名称 交易金额}.join('|') + "|\r\n"
    pay_infos = []
    post_infos.each {|pi| pay_infos += pi.pay_infos}
    pay_infos.each_with_index do |pi,index|
      ret += [index + 1,'6236682430006612194',pi.account_no,pi.account_name,pi.sum_act_pay_fee,"宇玖货款#{pi.org.simp_name}"].join('|') + "|\r\n"
    end
    ret
  end

  def self.batch_export_with_bank(ids,bank)
    ret = ""
    if bank.eql?('ccb')
      ret = self.batch_to_ccb_txt(ids)
    elsif bank.eql?('spd')
      ret = self.batch_to_spd_txt(ids)
    end
    require 'iconv'
    send_txt = Iconv.conv("gb2312//IGNORE","utf-8",ret)
  end

  #导出为建行txt
  def to_ccb_txt
    ret = %w{#序号 付款账户 收款账户 收款账户名称 交易金额}.join('|') + "|\r\n"
    self.pay_infos.each_with_index do |pi,index|
      ret += [index + 1,'6236682430006612194',pi.account_no,pi.account_name,pi.sum_act_pay_fee,"宇玖货款#{org.simp_name}"].join('|') + "|\r\n"
    end
    ret
  end

  #批量导出为浦发银行转账文本
  def self.batch_to_spd_txt(ids)
    post_infos = where(:id => ids)
    ret = ""
    pay_infos = []
    post_infos.each {|pi| pay_infos += pi.pay_infos}
    pay_infos.each_with_index do |pi,index|
      ret += [pi.account_no,pi.account_name,pi.sum_act_pay_fee,"宇玖货款#{pi.org.simp_name}"].join('|') + "|\r\n"
    end
    ret
  end


  #导出为浦发txt
  def to_spd_txt
    ret =  ""
    self.pay_infos.each_with_index do |pi,index|
      ret += [pi.account_no,pi.account_name,pi.sum_act_pay_fee,"宇玖货款#{org.simp_name}"].join('|') + "|\r\n"
    end
    ret
  end
  #生成凭证
  #生成短途运费报销凭证
  def build_accounting_document(context = {})
    context[:note_date] = Date.today.strftime("%Y-%m-%d") if not context[:note_date]
    context[:note_date] = context[:note_date][5..9]

    context[:org_name] = self.org.simp_name

    #借方
    dr = sum_goods_fee.to_i
    dr_lines = []
    dr_line = {
      :description => "付#{context[:org_name]}客户代收货款",
      #总账科目
      :gen_led =>  '应付账款',
      #明细科目
      :sub_led =>  '-',
      :dr => dr,
      :dr_str => dr.to_s
    }
    dr_lines.append(dr_line)
    #贷方
    cr_lines = []
    #实付货款
    cr_line_1 =  {
      :description => "",
      #总账科目
      :gen_led =>  '银行存款',
      #明细科目
      :sub_led =>  "",
      :cr => sum_act_pay_fee.to_i,
      :cr_str => sum_act_pay_fee.to_i.to_s
    }
    #其他收入/手续费
    cr_line_2 =  {
      :description => "",
      #总账科目
      :gen_led =>  '其他收入',
      #明细科目
      :sub_led =>  "手续费",
      :cr => sum_k_hand_fee.to_i,
      :cr_str => sum_k_hand_fee.to_i.to_s
    }

    #其他收入/保险费
    cr_line_3 =  {
      :description => "",
      #总账科目
      :gen_led =>  '',
      #明细科目
      :sub_led =>  "保险费",
      :cr => sum_k_insured_fee.to_i,
      :cr_str => sum_k_insured_fee.to_i.to_s
    }

    #营业收入
    cr_fee = sum_k_carrying_fee + sum_k_from_short_carrying_fee + sum_k_to_short_carrying_fee
    cr_line_4 =  {
      :description => "",
      #总账科目
      :gen_led =>  '营业收入',
      #明细科目
      :sub_led =>  "见附表",
      :cr => cr_fee.to_i,
      :cr_str => cr_fee.to_i.to_s
    }

    cr_lines.append(cr_line_1)
    cr_lines.append(cr_line_2)
    cr_lines.append(cr_line_3)
    cr_lines.append(cr_line_4)
    #计算分组明细
    cr_detail_lines,dr_detail_lines = self.build_detail
    return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
  end

  #创建短途费用明细
  def build_detail
    cr_detail_lines = []
    #按照到货地分组
    group_bills = self.carrying_bills.all.sort_by {|b| b.to_org.try(:order_by)}.group_by(&:to_org)

    group_bills.each do |org,bills|
      fee = bills.sum {|b| b.k_carrying_fee + b.k_from_short_carrying_fee + b.k_to_short_carrying_fee}.to_i
      cr_detail_lines.append({
        :item1 => org.simp_name,
        :item2 => "",
        :fee => fee,
        :fee_str => fee.to_s
      })
    end
    return cr_detail_lines,[]
  end

  private
  def self.carrying_bill_export_options
    {
      :only => [],
      :methods => [
        :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
        :pay_type_des,
        :k_carrying_fee,:k_hand_fee,:goods_fee,:act_pay_fee,
        :note,:human_state_name
      ]}
  end
  #生成分理处货款结算清单
  def create_goods_fee_settlement_list
    GoodsFeeSettlementList.create(:bill_date => self.bill_date,:org => self.org,:post_info => self,:user => self.user)
  end

end
