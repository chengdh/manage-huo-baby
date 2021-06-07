#coding: utf-8
#任务管理模块
class Task < ActiveRecord::Base
  validates :title,:content,:plan_complete_date,:state, presence: true
  belongs_to :creator,:class_name => "User"
  belongs_to :acceptor,:class_name => "User"
  belongs_to :submitor,:class_name => "User"
  belongs_to :auditor,:class_name => "User"

  has_many :task_users,:dependent => :destroy
  has_many :task_participation_users,:dependent => :destroy
  has_many :task_progresses,:dependent => :destroy

  has_many :users,:through => :task_users
  has_many :participation_users,:through => :task_participation_users,:source => :user

  accepts_nested_attributes_for :task_users,:allow_destroy => true,:reject_if => proc {|attrs| logger.debug(attrs) ; attrs['user_id'].blank?}
  accepts_nested_attributes_for :task_participation_users,:allow_destroy => true,:reject_if => proc {|attrs| attrs['user_id'].blank?}
  accepts_nested_attributes_for :task_progresses,:allow_destroy => true,:reject_if => proc {|attrs| attrs['user_id'].blank? or attrs['content'].blank?}


  default_value_for :plan_complete_date do
    Date.today.end_of_week
  end
  #定义状态机
  state_machine :initial => :draft do
    event :process do
      #草稿 -- 已保存 -- 已下发 -- 已接收 --- 已完成
      transition :draft => :saved,:saved => :sended,:sended => :accepted,:accepted=> :finished
    end

    #拒绝
    event :reject do
      transition :finished => :accepted
    end
  end
  def audit_state_des
    ret = ""
    ret = "通过" if audit_state.eql?("pass")
    ret = "驳回" if audit_state.eql?("reject")
    ret
  end
  def users_list
    users.join(",")
  end
  def participation_users_list
    participation_users.join(",")
  end
end
