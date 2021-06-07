# -*- encoding : utf-8 -*-
require 'ruby-pinyin/pinyin'
class Org < ActiveRecord::Base
  attr_accessor :all_org_permits
  default_scope order("order_by ASC")
  validates_presence_of :name
  validates :agtscf_rate, :numericality => true
  acts_as_tree :order => :name
  before_create :gen_py
  #客户级别设置
  has_many :customer_level_configs
  has_many :user_orgs
  has_many :org_permits
  belongs_to :yard,:class_name => "Org"

  #当前机构设定要排除的到货地
  has_many :permit_orgs,:through => :org_permits,:source => :permit_org,:conditions => ["org_permits.is_select = ?",true]

  accepts_nested_attributes_for :customer_level_configs
  accepts_nested_attributes_for :org_permits,:allow_destroy => true

  default_value_for :lock_input_time,"21:30"
  default_value_for :limit_goods_fee,9999999

  def self.new_with_config(attrs={})
    org = self.new(attrs)
    CustomerLevelConfig.levels.each do |key,value|
      org.customer_level_configs.build(:name => key,:from_fee => CustomerLevelConfig.system_level_range(key).begin,:to_fee => CustomerLevelConfig.system_level_range(key).end)
    end
    org
  end
  #获取当前机构可显示的到货地列表
  def to_orgs_list(show_summary = true,only_visible = true)
    #除去当前默认org和当前org的上级机构
    ret_orgs = []
    if self.in_summary?
      cur_org_id = self.id
      parent_id = self.parent_id
      exclude_ids =[self.id]
      exclude_ids << parent_id if parent_id.present?
      exclude_ids += Org.where(:parent_id => parent_id).collect(&:id) if parent_id.present?
      exclude_ids += Org.where(:parent_id => cur_org_id).collect(&:id)
      exclude_ids.uniq!
      critial = {:is_active_eq => true,:id_ni => exclude_ids}
      critial[:is_visible_eq] = only_visible if only_visible
      ret_orgs = Branch.search(critial).all
    else
      summary_org = Org.find_by_is_summary(true)
      ret_orgs.push(summary_org) if show_summary
      if summary_org.present?
        critial = {:parent_id => summary_org.id,:is_active => true}
        critial[:is_visible] = only_visible if only_visible
        summary_children = Org.where(critial)
        ret_orgs += summary_children
      end
      ret_orgs.uniq!
      ret_orgs.compact!
    end
    ret_orgs
  end


  #显示所有可到货部门,包括当前部门具备与不具备的部门
  def all_org_permits!
    if self.all_org_permits.blank?
      self.to_orgs_list.each do |org|
        self.org_permits.build(:permit_org => org) unless self.org_permits.detect { |the_org_permit| the_org_permit.permit_org.id == org.id }
      end
      self.all_org_permits ||= self.org_permits.to_a.select {|op| op.permit_org.is_active?}
    end
    self.all_org_permits
  end

  #获取机构下的用户列表-根据default_org_id
  def users_by_default_org_id
    User.where(:default_org_id => id,:is_active => true)
  end

  #重写to_s方法
  def to_s
    self.name
  end
  #是否超过录单时间
  def input_expire?
    ret = !self.lock_input_time.blank?
    ret = Time.now.strftime('%H:%M') >= self.lock_input_time if self.lock_input_time.present?
    ret
  end
  #是否属于总公司
  def in_summary?
    self.is_summary? || self.parent.try(:is_summary?)
  end

  #分理处列表
  def self.department_list
    summary_org = Org.find_by_is_summary_and_is_active(true,true)
    Org.where(:is_active => true,:parent_id => summary_org.try(:id))
  end
  #分公司列表
  #include_sub_branch 是否包含分公司二级机构
  def self.branch_list(parent_id = nil,include_sub_branch = false)
    branch_ids = self.branch_list_ids(parent_id,include_sub_branch)
    Org.where(:id => branch_ids)
  end
  def self.department_list_ids
    ids = department_list.collect(&:id)
    ids
  end

  #include_sub_branch 是否包含分公司二级机构
  def self.branch_list_ids(parent_id = nil,include_sub_branch = false)
    branch_ids = Org.where(:is_active => true,:is_summary => false,:parent_id => parent_id).pluck(:id)
    if include_sub_branch
      sub_branch_ids = Org.where(:is_active => true,:is_summary => false,:parent_id => branch_ids).pluck(:id)
      branch_ids += sub_branch_ids
    end
    branch_ids
  end

  #获取总部机构
  def self.all_summary_orgs
    where(:is_active => true,:is_summary => true)
  end

  #获取非总部机构
  def self.exclude_summary_orgs
    summary_ids = where(:is_summary => true).pluck(:id)
    where(:is_active => true,:is_summary => false).where("parent_id IS NULL or parent_id NOT IN (?)",summary_ids)
  end


  private
  def gen_py
    py = PinYin.instance
    self.py = py.to_pinyin_abbr(self.name)
  end
end
