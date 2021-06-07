#coding: utf-8
#实际装车清单明细
class ActLoadListLine < ActiveRecord::Base
  #虚拟属性,用于判断数据是否选中
  attr_accessor :_select,:rest_num,:branch_reached_num,:line_type
  #虚拟属性,用于记录运单剩余未装车数量
  belongs_to :carrying_bill
  belongs_to :act_load_list
  validates_presence_of :carrying_bill_id
  #创建时装车明细时,
  #装车数量要小于等于运单剩余未装车数量
  # validates_numericality_of :load_num,:less_than_or_equal_to => Proc.new {|line| line.rest_num.to_i },:message => "不能大于剩余数量",:on => :create

  #确认数量不能大于装车数量
  # validates_numericality_of :confirm_num,:less_than_or_equal_to => Proc.new {|line| line.load_num },:message => "不能大于装车数量",:on => :update

  default_scope :include => [:carrying_bill]

  default_value_for :_select,true
  default_value_for :load_num do |line|
    line.try(:rest_num)
  end

  #排序
  def order_by
    self.try(:carrying_bill).try(:from_org).try(:order_by).to_i + self.try(:carrying_bill).try(:to_org).try(:order_by).to_i
  end
end
