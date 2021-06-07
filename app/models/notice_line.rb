#coding: utf-8
#通知信息明细
class NoticeLine < ActiveRecord::Base
  include NoticesHelper
  #_select 判断前端是否选中
  attr_accessor :_select
  belongs_to :notice
  belongs_to :carrying_bill
  #虚拟属性,用于判断数据是否选中
  attr_accessor :_select
  default_value_for :_select,false
  default_value_for :sms_state,'draft'
  default_value_for :calling_state,'draft'
 # before_validation :set_notice_info

  validates :carrying_bill_id,:calling_text,:calling_state,:sms_state,:presence => true

  #状态描述
  def calling_state_desc
    notice_line_state_desc(self.calling_state)
  end
  #状态描述
  def sms_state_desc
    notice_line_state_desc(self.sms_state)
  end

  private
  #FIXME 不再使用
  def set_notice_info
    self.from_customer_phone = carrying_bill.notice_phone_for_arrive
    self.calling_text = carrying_bill.calling_text_for_arrive
    #收货人电话是手机时才生成短信文本
    self.sms_text = carrying_bill.sms_text_for_arrive if mobile?(self.from_customer_phone)
  end
end
