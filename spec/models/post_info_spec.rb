# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe PostInfo do
  before(:each) do
    @computer_bill = Factory(:computer_bill_paid)
    @post_info = Factory.build(:post_info)
    @post_info.carrying_bills << @computer_bill
  end
  it "应能够正确保存每日过帐信息" do
    @post_info.save!
  end
  it "过帐清单保存后,状态应变为'已过帐'" do
    @post_info.save!
    @post_info.process
    @post_info.reload
    @computer_bill.reload
    @post_info.should be_posted
    @computer_bill.should be_posted
  end
end

