#coding: utf-8
#运费调整
class AdjustFeeInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :op_org,:class_name => "Org"
  belongs_to :user
  belongs_to :op_user,:class_name => "User"
  belongs_to :carrying_bill
  #attr_accessible :note,:org_id,:op_org_id,:user_id,:op_user_id,:op_datetime,:state,:note,:adjust_fee,:bill_date,:carrying_bill_id
  validates_presence_of :org_id,:op_org_id,:carrying_bill_id,:bill_date

  before_create :set_origin_carrying_fee

  #运费调整不能大于原运费
  validate :check_adjust_fee
  validate :check_duplicate,:on => :create
  #定义状态机
  state_machine :initial => :submited do
    after_transition :on => :pass,:submited => :authorized do |info,ts|
      info.update_attributes(:op_datetime => DateTime.now)
      #NOTE 20140418,不再处理运费修改
      #NOTE 20170430,处理运费修改
      carrying_bill = info.carrying_bill
      carrying_bill.update_attributes(:carrying_fee => carrying_bill.carrying_fee + info.adjust_fee)
    end
    after_transition :on => :deny,:submited => :denied do |info,ts|
      info.update_attributes(:op_datetime => DateTime.now)
    end

    event :pass do
      #草稿 -- 已上报 -- 已核销
      transition :submited =>:authorized
    end
    #驳回
    event :deny do
      transition :submited => :denied
    end
    #重新上报
    event :re_submit do
      transition :denied => :submited
    end
  end

  #缺省值设定应定义到state_machine之后
  default_value_for :bill_date do
    Date.today
  end

  #货号
  def goods_no
    self.carrying_bill.try(:goods_no)
  end
  #运单编号
  def bill_no
    self.carrying_bill.try(:bill_no)
  end
  #调整后的运费
  def after_adjust_carrying_fee
    self.origin_carrying_fee + self.adjust_fee
  end


  private
  def check_adjust_fee
    errors.add(:except_fee,"不能大于原运单运费!") if self.carrying_bill and self.adjust_fee + self.carrying_bill.carrying_fee < 0
  end
  #不可重复上报
  def check_duplicate
    errors.add(:except_fee,"不能重复调整运费!") if carrying_bill.try(:adjust_fee_infos).present?
  end
  def set_origin_carrying_fee
    self.origin_carrying_fee = self.carrying_bill.carrying_fee
  end
end
