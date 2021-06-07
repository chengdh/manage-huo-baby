# -*- encoding : utf-8 -*-

class User < ActiveRecord::Base
  acts_as_voter

  attr_accessor :all_user_orgs

  # Include default devise modules. Others available are:

  # :token_authenticatable, :confirmable, :lockable and :timeoutable

  devise :token_authenticatable,:database_authenticatable,#:registerable,

    :rememberable, :trackable #:recoverable



  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me,

    :username,:is_admin,:default_role_id,:default_org_id,:is_active,

    :user_roles_attributes,:user_orgs_attributes,:use_usb,:usb_pin,

    :real_name,:created_at,:updated_at



  validates_presence_of :username,:real_name

  validates :password,:confirmation => true

  has_many :user_roles,:include => :role

  has_many :roles,:through => :user_roles

  has_many :user_orgs,:include => :org

  has_many :orgs,:through => :user_orgs

  belongs_to :default_org,:class_name => "Org",:touch => true

  belongs_to :default_role,:class_name => "Role",:touch => true

  accepts_nested_attributes_for :user_roles,:user_orgs,:allow_destroy => true

  default_scope :include => [:default_role,:default_org]



  def self.new_with_roles(attrs= {})

    ret = User.new(attrs)

    ret.all_user_roles!

    ret.all_user_orgs!

    #创建之前,写入usb_pin

    ret.set_usb_pin

    ret

  end

  #显示所有部门,包括当前角色具备与不具备的部门

  def all_user_roles!

    Role.where(:is_active => true).each do |role|

      self.user_roles.build(:role => role) unless self.user_roles.detect { |the_user_role| the_user_role.role.id == role.id }

    end

    self.user_roles.to_a.select {|ur| ur.role.is_active?}

  end

  #显示所有部门,包括当前角色具备与不具备的部门

  def all_user_orgs!

    if self.all_user_orgs.blank?

      Org.where(:is_active => true).order("name ASC").each do |org|

        self.user_orgs.build(:org => org) unless self.user_orgs.detect { |the_user_org| the_user_org.org.id == org.id }

      end

      self.all_user_orgs ||= self.user_orgs.to_a.select {|uo| uo.org.is_active?}

    end

    self.all_user_orgs

  end



  #得到当前用户可访问的部门

  #如果是最末级机构,只可访问自己的数据,如果是上级机构,则可访问所有下级机构数据

  #FIXME 注意,当前只支持二级机构

  def current_ability_orgs
    [self.default_org] + self.default_org.children
  end

  def current_ability_org_ids
    self.current_ability_orgs.map {|org| org.id}
  end

  def to_s
    self.real_name
  end

  #设置usb pin

  def set_usb_pin
    self.usb_pin = UUID.generate(:compact)
  end

  #获取第一个管理员用户
  def self.first_admin
    User.find_by_is_active_and_is_admin(true,true)
  end

end
