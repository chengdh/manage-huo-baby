#coding: utf-8
#通知公告/规章制度处理
class Message < ActiveRecord::Base
  #取消sti
  self.inheritance_column = :_type_disabled
  belongs_to :user
  has_many :message_histories
  has_many :message_users
  has_many :users,:through => :message_users
  accepts_nested_attributes_for :message_users

  belongs_to :publisher,:class_name => "User"
  default_value_for :type,'Notice'
  default_value_for :is_secure,0
  default_value_for :publish_date do
    Date.today
  end

  #获取当前用户未读的提醒信息
  scope :unread,lambda{|cur_user_id| where(" messages.state='published' AND publish_date >= '2013-07-01' " +
                                           " AND is_secure = 0 " +
                                           " AND messages.type in ('Rule','Notice')" +
                                           " AND NOT EXISTS" +
                                           " (SELECT message_id from message_histories" +
                                           " WHERE messages.id = message_histories.message_id" +
                                           " AND user_id = ? ) ",cur_user_id).limit(10).order('publish_date DESC')}

  scope :unread_secure,lambda {|user_id| joins(:message_users).where([" messages.state='published'" +
                                                                      " and messages.is_secure=1" +
                                                                      " and messages.id = message_users.message_id" +
                                                                      " and message_users.user_id = ? " +
                                                                      " and not exists" +
                                                                      " (SELECT message_id from message_histories" +
                                                                      " WHERE messages.id = message_histories.message_id" +
                                                                      " AND user_id = ? ) ",user_id,user_id]).limit(1).order('publish_date DESC')}
  scope :unread_public,lambda {|user_id| where(" messages.state='published'" +
                                               " and not exists" +
                                               " (SELECT message_id from message_histories" +
                                               " WHERE messages.id = message_histories.message_id" +
                                               " AND user_id = ? ) ",user_id).limit(1).order('publish_date DESC')}
  def self.update_view_count(message_id,user_id)
    #保存查看记录
    message_history = MessageHistory.find_or_create_by_message_id_and_user_id(message_id,user_id)
    message_history.update_attributes(:view_count => message_history.view_count + 1)
  end
  default_value_for :is_secure,false

  #定义状态机
  #发布
  state_machine :initial => :draft do
    event :publish do
      transition :draft => :published
    end
    event :unpublish do
      transition  :published => :draft
    end
  end
  def users_list
    ret = ""
    if users.blank?
      ret = "全体"
    else
      ret = users.join(",")
    end
    ret
  end
end
