# -*- encoding : utf-8 -*-
#coding: utf-8
class Role < ActiveRecord::Base
  attr_accessor :all_role_sfos
  validates_presence_of :name
  has_many :user_roles
  has_many :users,:through => :user_roles,:uniq => true
  has_many :role_system_function_operates,:include => :system_function_operate
  #is_select标志为true的role_system_function_operates
  has_many :selected_rsfos,:class_name => "RoleSystemFunctionOperate",:conditions => {:is_select => true}
  has_many :selected_sfos,:class_name => "SystemFunctionOperate",:through => :selected_rsfos,:uniq => true,:source =>:system_function_operate,:include => :system_function
  has_many :system_function_operates,:through => :role_system_function_operates,:uniq => true,:include => :system_function
  accepts_nested_attributes_for :role_system_function_operates,:allow_destroy => true

  validates :name,:presence => true,:uniqueness => true
  scope :with_association, :include => [:role_system_function_operates,:system_function_operates]

  #显示所有系统功能,包括当前角色具备的功能
  def all_role_system_function_operates!
    if self.all_role_sfos.blank?
      SystemFunctionOperate.where(:is_active => true).order("system_function_id").each do |sf_operate|
        self.role_system_function_operates.build(:system_function_operate => sf_operate) unless self.role_system_function_operates.detect { |the_rsf_op| the_rsf_op.system_function_operate_id == sf_operate.id }
      end
      self.all_role_sfos = self.role_system_function_operates
    end
    self.all_role_sfos
  end
  #根据系统功能得到对应的role_system_function_operate
  def single_function_operates(sf)
    self.all_role_system_function_operates!.select {|ops| ops.system_function_operate.system_function_id == sf.id}
    #@all_role_sfos.search(:system_function_operate_system_function_id_eq => sf.id).all
  end

  def self.new_with_default(attributes = nil)
    role = Role.new(attributes)
    SystemFunctionOperate.where(:is_active => true).order("system_function_id").each do |sf_operate|
      role.role_system_function_operates.build(:system_function_operate => sf_operate)
    end
    role
  end
  #得到被授权的system_function
  def system_functions
    ids = self.selected_sfos.collect {|sfo| sfo.system_function_id}.uniq!
    if ids.blank?
      @system_finctions =[]
    else
      @system_functions ||= SystemFunction.find(ids,:conditions => {:is_active => true},:include => [:system_function_group]) if ids.present?
    end
  end
  #得到被授权的system_function_group
  def system_function_groups
    @system_function_groups ||= self.system_functions.group_by(&:system_function_group).sort_by {|k,v| k.order}
  end
  #重写to_s方法
  def to_s
    self.name
  end
end

