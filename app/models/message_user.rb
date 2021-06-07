#coding: utf-8
class MessageUser < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
end
