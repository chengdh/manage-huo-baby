# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe DistributionList do
  before(:each) do
    @computer_bill = Factory(:computer_bill_reached)
    @distribution_list = Factory.build(:distribution_list)
    @distribution_list.carrying_bills << @computer_bill
  end
  it "应能正确保存分货单" do
    @distribution_list.save!
  end
  it "分货单处理后,其状态应变为'已分货'" do
    @distribution_list.process

    @distribution_list.should be_distributed
    @computer_bill.should be_distributed
  end
end

