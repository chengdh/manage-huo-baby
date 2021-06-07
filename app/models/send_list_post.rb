# -*- encoding : utf-8 -*-
#coding: utf-8
class SendListPost < ActiveRecord::Base
  include SendListModule
  belongs_to :user
  belongs_to :org
  belongs_to :sender
  has_many :send_list_lines
  has_many :carrying_bills,:through => :send_list_lines,:order => "goods_no ASC"

  default_value_for :bill_date do
    Date.today
  end
  validates_presence_of :sender_id,:org_id
end

