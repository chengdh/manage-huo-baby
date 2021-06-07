#coding: utf-8
#load_list base class
class BaseLoadList < ActiveRecord::Base
  self.table_name = "load_lists"
  default_scope :include => [:from_org,:to_org,:user]
  belongs_to :from_org,:class_name => "Org"
  belongs_to :transit_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :user
  belongs_to :reached_user,:class_name => "User"
  belongs_to :transit_reached_user,:class_name => "User"
  belongs_to :transit_ship_user,:class_name => "User"

  has_many :carrying_bills,:order => "goods_no ASC",:foreign_key => "load_list_id"
  #可以有多个提醒记录
  has_many :notices,:foreign_key => "load_list_id"

  has_many :scan_lines,:foreign_key => "load_list_id"

  validates_presence_of :from_org_id,:to_org_id,:bill_no
  #待确认收货清单
  scope :shipped,lambda {|to_org_ids| select("sum(1) as bill_count").where(:state => :shipped,:to_org_id => to_org_ids)}
  #发货地查看中转清单
  scope :from_org_transit_bills,lambda {|org_ids| where(["from_org_id in (#{org_ids.join(',')}) AND transit_org_id IS NOT NULL"])}
  #中转地查看中转运单
  scope :transit_org_transit_bills,lambda {|org_ids| where(["state in ('shipped','transit_reached','transit_shipped','reached') AND transit_org_id in (#{org_ids.join(',')})"])}
  #到货地
  scope :to_org_transit_bills,lambda {|org_ids| where(["state in ('transit_shipped','reached') AND to_org_id in (#{org_ids.join(',')}) AND transit_org_id IS NOT NULL"])}

  #定义状态机
  state_machine :initial => :billed do
    after_transition do |load_list,transition|
      load_list.carrying_bills.each {|bill| bill.standard_process}
    end
    before_transition :loaded => :shipped do |load_list,transition|
      #生成预付款凭据
      PrepayEntry.last_entry(load_list.to_org_id)
    end

    after_transition :loaded => :shipped do |load_list,transition|
      #生成预付款凭据
      PrepayEntry.create_from_load_list(load_list)
    end
    #到货确认后,设置确认时间
    after_transition :shipped => :reached,:transit_shipped => :reached do |load_list,transition|
      load_list.update_attributes(:reached_datetime => DateTime.now)
      load_list.update_attributes(:reached_date => Date.today)
    end
    event :process do
      transition :billed =>:loaded,:loaded => :shipped
      transition :shipped => :reached,:if => lambda {|bill| bill.transit_org_id.blank?}
      transition :shipped => :transit_reached,:transit_reached => :transit_shipped,
        :transit_shipped => :reached,:if => lambda {|bill| bill.transit_org_id.present?}
    end
  end

  #NOTE 缺省值设定应定义到state_machine之后
  default_value_for :bill_date do
    Date.today
  end

  def from_org_name
    self.from_org.try(:name)
  end
  def to_org_name
    self.to_org.try(:name)
  end
  def from_to_des
    "#{self.from_org.try(:name)}~#{self.transit_org.try(:name)}~#{self.to_org.try(:name)}" if self.transit_org.present?
    "#{self.from_org.try(:name)}~#{self.to_org.try(:name)}" if self.transit_org.blank?
  end
  #生成act_load_list_line
  def build_act_load_list
    act_load_list = YardInventory.new(:bill_no => self.bill_no,:from_org => self.from_org,:to_org => self.to_org,:load_list => self)
    self.carrying_bills.each do |bill|
      act_load_list.act_load_list_lines.build(:carrying_bill => bill,:rest_num => bill.goods_num)
    end
    act_load_list
  end
  #2012-7-3
  #创建电话提醒信息,只是创建,并未保存到数据库
  def build_notice
    notice=self.notices.build(:org => self.to_org,:bill_date => self.bill_date,:note => "#{self.bill_date}:#{self.from_org.name} ~ #{self.to_org.try(:name)}")
    notice.notice_lines << self.carrying_bills.map {|bill| NoticeLine.new(:carrying_bill => bill,:from_customer_phone => bill.notice_phone_for_arrive,:calling_text => bill.calling_text_for_arrive,:sms_text => bill.sms_text_for_arrive)}
    notice
  end
  #导出到csv
  def to_csv
    ret = ["清单日期:",self.bill_date,"清单编号:",self.bill_no,"发货站:",self.from_org_name,"到达站:",self.to_org_name,"状态:" , self.human_state_name].export_line_csv(true)
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,LoadList.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  #导出sms群发文本
  def to_sms_txt(ids = {})
    #去除固定电话和空号
    sms_bills = self.carrying_bills.find(ids).find_all {|bill| bill.sms_mobile_for_arrive.present? }
    no_mobile_sms_bills = self.carrying_bills.find(ids).find_all {|bill| bill.sms_mobile_for_arrive.blank? }
    group_sms_bills = sms_bills.group_by(&:sms_mobile_for_arrive)
    #分别合计货物件数/运费合计/货款合计
    sms_text = ''
    group_sms_bills.each do |key,bills|
      #goods_num = bills.to_a.sum(&:goods_num)
      goods_nos = []
      bills.each do |the_bill|
        goods_nos << the_bill.goods_no[6..-1]
      end
      goods_fee = bills.to_a.sum(&:th_amount).to_i
      sms_text += Settings.notice_arrive.sms_batch % [key,self.to_org.try(:name),goods_nos.join(" "),goods_fee,self.to_org.try(:location),self.to_org.try(:phone)]
    end
    sms_text +="===============================以下运单无手机号===============================================\r\n"
    no_mobile_sms_bills.each do |bill|
      goods_no = bill.goods_no[6..-1]
      sms_text += Settings.notice_arrive.sms_batch % [bill.try(:phone_or_mobile_for_arrive),self.to_org.try(:name),goods_no,bill.th_amount,self.to_org.try(:location),self.to_org.try(:phone)]
    end
    sms_text
  end
  #重写to_s
  def to_s
    self.bill_no
  end

  private
  def self.carrying_bill_export_options
    {
      :only => [],
      :methods => [
        :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
        :to_customer_name,:to_customer_phone,:to_customer_mobile,
        :pay_type_des,
        :carrying_fee,:goods_fee,
        :note,:human_state_name
      ]
    }
  end
end
