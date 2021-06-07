# -*- encoding : utf-8 -*-
#coding: utf-8
class ShortFeeInfo < ActiveRecord::Base
  belongs_to :org
  #核销部门
  belongs_to :op_org,:class_name => "Org"
  belongs_to :user
  has_many :short_fee_info_lines,:dependent => :destroy
  has_many :carrying_bills,:through => :short_fee_info_lines
  validates_presence_of :org_id,:bill_date

  #定义状态机
  state_machine :initial => :draft do
    after_transition do |info,transition|
      #更新核销时间
      info.update_attributes(:write_off_date => Date.today)
      info.carrying_bills.each do |bill|
        bill.write_off_from_short_fee! if info.org_id.eql?(bill.from_org_id)
        bill.write_off_to_short_fee! if info.org_id.eql?(bill.to_org_id)
      end
    end
    event :write_off do
      transition :draft => :saved,:saved => :offed
    end
  end

  #缺省值设定应定义到state_machine之后
  default_value_for :bill_date do
    Date.today
  end
  #报销金额合
  def sum_write_off_fee
    children_ids = org.children.collect(&:id)
    org_ids = [org_id] + children_ids
    sum_from = self.carrying_bills.sum(:from_short_carrying_fee,:conditions => {:from_org_id => org_ids})
    sum_to = self.carrying_bills.sum(:to_short_carrying_fee,:conditions => {:to_org_id => org_ids})
    sum_from + sum_to
  end

  #生成短途运费报销凭证
  def build_accounting_document(context = {})
    context[:note_date] = Date.today.strftime("%Y-%m-%d") if not context[:note_date]
    context[:note_date] = context[:note_date][5..9]

    context[:org_name] = self.org.simp_name
    from_short_carrying_fee = self.carrying_bills.sum(:from_short_carrying_fee).to_i
    to_short_carrying_fee = self.carrying_bills.sum(:to_short_carrying_fee).to_i

    #借方
    dr_lines = []
    dr =  from_short_carrying_fee if self.fee_type.eql?('from')
    dr =  to_short_carrying_fee if self.fee_type.eql?('to')
    dr_line = {
      :description => "短途费用",
      #总账科目
      :gen_led =>  '短途费用',
      #明细科目
      :sub_led =>  '见附表',
      :dr => dr,
      :dr_str => dr.to_s
    }
    dr_lines.append(dr_line)
    #贷方
    cr_lines = []
    #运费
    cr_line_1 =  {
      :description => "",
      #总账科目
      :gen_led =>  '应付短途',
      #明细科目
      :sub_led =>  "#{context[:org_name]}",
      :cr => dr,
      :cr_str => dr.to_s
    }
    cr_lines.append(cr_line_1)
    #计算分组明细
    cr_detail_lines,dr_detail_lines = self.build_detail
    return cr_lines,dr_lines,cr_detail_lines,dr_detail_lines,context
  end

  #创建短途费用明细
  def build_detail
    dr_detail_lines = []

    group_bills = {}
    #按照到货地分组
    group_bills = self.carrying_bills.all.sort_by {|b| b.to_org.try(:order_by)}.group_by(&:to_org) if self.fee_type.eql?('from')
    #按照发货地分组
    group_bills = self.carrying_bills.all.sort_by {|b| b.from_org.try(:order_by)}.group_by(&:from_org) if self.fee_type.eql?('to')

    group_bills.each do |org,bills|
      fee = bills.sum {|b| b.from_short_carrying_fee}.to_i if self.fee_type.eql?('from') 
      fee = bills.sum {|b| b.to_short_carrying_fee}.to_i if self.fee_type.eql?('to')
      dr_detail_lines.append({
        :item1 => org.simp_name,
        :item2 => "",
        :fee => fee,
        :fee_str => fee.to_s
      })
    end
    return [],dr_detail_lines
  end
end
