# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe DeliverInfo do
  before :each do
    @computer_bill = Factory(:computer_bill_distributed)
    @deliver_info = Factory.build(:deliver_info)
    @deliver_info.carrying_bills << @computer_bill
  end
  it "应能正确保存提货单" do
    @deliver_info.save!
  end
  it "必须要录入提货人姓名" do
    @deliver_info.customer_name = nil
    @deliver_info.should_not be_valid
  end
  it "处理后,提货单应变为已提货状态" do
    @deliver_info.process
    @deliver_info.should be_deliveried
    @computer_bill.should be_deliveried
  end
end

