# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Settlement do
  before :each do
    @computer_bill = Factory(:computer_bill_deliveried)
    @settlement = Factory.build(:settlement)
    @settlement.carrying_bills << @computer_bill
  end
  it "应能正确保存提货单" do
    @settlement.save!
  end
  it "必须要结算单位" do
    @settlement.org_id = nil
    @settlement.should_not be_valid
  end
  it "处理后,结算单应变为已结算状态" do
    @settlement.process
    @settlement.should be_settlemented
    @computer_bill.should be_settlemented
  end

end

