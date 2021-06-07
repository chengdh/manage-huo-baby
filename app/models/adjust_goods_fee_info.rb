#coding: utf-8
class AdjustGoodsFeeInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :op_org,:class_name => "Org"
  belongs_to :user
  belongs_to :op_user,:class_name => "User"
  belongs_to :carrying_bill
  validates_presence_of :org_id,:op_org_id,:carrying_bill_id,:bill_date

  before_create :set_origin_goods_fee

  #运费调整不能大于原运费
  validate :check_adjust_goods_fee
  # validate :check_duplicate,:on => :create
  #定义状态机
  state_machine :initial => :submited do
    after_transition :on => :pass,:submited => :authorized do |info,ts|
      info.update_attributes(:op_datetime => DateTime.now)
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
  default_value_for :adjust_goods_fee,0

  #货号
  def goods_no
    carrying_bill.try(:goods_no)
  end
  #运单编号
  def bill_no
    carrying_bill.try(:bill_no)
  end
  #调整后的运费
  def after_adjust_goods_fee
    adjust_goods_fee
  end


  private
  def check_adjust_goods_fee
    errors.add(:except_fee,"不能大于原运单货款!") if carrying_bill and self.adjust_goods_fee + self.carrying_bill.goods_fee < 0
  end
  #不可重复上报
  def check_duplicate
    errors.add(:except_fee,"不能重复调整货款!") if carrying_bill.try(:adjust_goods_fee_infos).present?
  end
  def set_origin_goods_fee
    self.origin_goods_fee = carrying_bill.goods_fee
  end
end
