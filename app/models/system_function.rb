# -*- encoding : utf-8 -*-
#系统功能类
class SystemFunction < ActiveRecord::Base
  default_scope order("`order` ASC")
  belongs_to :system_function_group
  has_many :system_function_operates,:dependent => :destroy
  #根据传入的hash生成system_function,在rake task中调用
  def self.create_by_hash(attrs ={})
    group = SystemFunctionGroup.find_or_create_by_name(attrs[:group_name])
    sf = group.system_functions.create(:subject_title => attrs[:subject_title],:default_action => attrs[:default_action])
    attrs[:function].each do |key,value|
      sfo = sf.system_function_operates.build(:name => value[:title])
      sfo.function_obj = {:subject => attrs[:subject],:action => key,:conditions => value[:conditions]}
      sfo.new_function_obj = {:subject => attrs[:subject],:action => key,:conditions => value[:conditions]}
      sfo.save!
    end
  end
  #更新原有功能
  def update_by_hash(attrs={})
    if attrs[:subject_title].present?
      self.update_attributes(:subject_title => attrs[:subject_title])
    end
    if attrs[:group_name].present?
      group = SystemFunctionGroup.find_or_create_by_name(attrs[:group_name])
      self.update_attributes(:system_function_group => group)
    end
    if attrs[:default_action].present?
      self.update_attributes(:default_action => attrs[:default_action])
    end

    attrs[:function].each do |key,value|
      sfo = self.system_function_operates.find_by_name(value[:title])
      sfo = self.system_function_operates.build(:name => value[:title]) unless sfo
      sfo.function_obj = {:subject => attrs[:subject],:action => key,:conditions => value[:conditions]}
      sfo.new_function_obj = {:subject => attrs[:subject],:action => key,:conditions => value[:conditions]}
      sfo.save!
    end
  end
  #创建或更新原有功能
  def self.generate_by_hash(attrs={})
    sf = SystemFunction.find_by_subject_title(attrs[:subject_title])
    self.create_by_hash(attrs) unless sf
    sf.update_by_hash(attrs) if sf
  end
end
