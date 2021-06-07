#coding: utf-8
#短驳单
class ShortList < ActiveRecord::Base
  default_scope :include => [:from_org,:to_org,:user]
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :user
  belongs_to :reached_user,:class_name => "User"
  has_many :carrying_bills

  validates :from_org_id,:to_org_id,:user_id,:presence => true

  accepts_nested_attributes_for :carrying_bills


  #定义状态机
  state_machine :initial => :billed do
    after_transition :billed => :loaded do |short_list,transition|
      short_list.carrying_bills.update_all("state = 'short_list_loaded'","state = 'billed'")
    end
    #发车
    after_transition :loaded => :shipped do |short_list,transition|
      short_list.carrying_bills.update_all("state = 'short_list_shipped'","state = 'short_list_loaded'")
    end

    #到货确认后,设置确认时间
    after_transition :shipped => :reached do |short_list,transition|
      short_list.update_attributes(:reached_datetime => DateTime.now)
      short_list.carrying_bills.update_all("state = 'short_list_reached'","state = 'short_list_shipped'")
    end
    event :process do
      transition :billed => :loaded,:loaded => :shipped,:shipped => :reached
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

  #创建并执行操作
  def self.create_and_process(attr_vals)
    sh = self.new(attr_vals)
    sh.save!
    #装车
    sh.process
    #发车
    sh.process
    #到货
    sh.process
    sh
  end
end
