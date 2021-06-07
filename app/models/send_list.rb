# -*- encoding : utf-8 -*-
#coding: utf-8
class SendList < ActiveRecord::Base
  include SendListModule
  belongs_to :sender
  belongs_to :org
  belongs_to :user
  has_many :send_list_lines
  has_many :carrying_bills,:through => :send_list_lines

  validates_presence_of :org_id,:bill_date

  default_value_for :bill_date do
    Date.today
  end
end

