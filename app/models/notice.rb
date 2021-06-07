#coding: utf-8
#通知信息主表-语音、短信通知使用
class Notice < ActiveRecord::Base
  include NoticesHelper
  belongs_to :org
  belongs_to :load_list
  belongs_to :user
  has_many :notice_lines,:dependent => :delete_all,:include => :carrying_bill
  has_many :carrying_bills,:through => :notice_lines
  #未选中的数据、无电话的数据自动过滤
  #FIXME  修改时有问题
  accepts_nested_attributes_for :notice_lines,:reject_if => proc {|attrs|attrs['from_customer_phone'].blank? || attrs['_select'].eql?('0') }

  validates_presence_of :org_id
  default_value_for :state,'draft'
  default_value_for :bill_date do
    Date.today
  end
  #状态描述
  def state_desc
    notice_state_desc(self.state)
  end
end
