# -*- encoding : utf-8 -*-
#多货少货信息
class GoodsError < ActiveRecord::Base
  belongs_to :carrying_bill
  belongs_to :org
  #处理部门
  belongs_to :op_org,:class_name => "Org"
  belongs_to :user
  has_one :gerror_authorize
  accepts_nested_attributes_for :gerror_authorize
  #异常数量不能大于货物数量
  validates_presence_of :org_id,:op_org_id
  #定义状态机
  state_machine :initial => :submited do
    event :process do
      #已上报 -- 已核销
      transition :submited =>:authorized
    end
  end

  #缺省值设定应定义到state_machine之后
  default_value_for :bill_date do
    Date.today
  end

  EXCEPT_SHORTAGE = "SH"      #短缺
  EXCEPT_OVERFLOW = "OF"      #多货
  #付款方式描述
  def self.except_types
    {
      #"少货" => EXCEPT_SHORTAGE,      #短缺
      "多货" => EXCEPT_OVERFLOW        #破损
    }
  end
  def except_des
      except_des = ""
      GoodsError.except_types.each {|des,code| except_des = des if code == self.except_type }
      except_des
  end
end

