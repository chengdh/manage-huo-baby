#coding: utf-8
require 'spec_helper'

describe AdjustFeeInfo do
  before :each do
    @adjust_fee_info = Factory.build(:adjust_fee_info)
  end

  it "应能够正确保存运费调整信息" do
    @adjust_fee_info.save!.should == true
  end

  it "调整费用大运原运费时,信息验证不通过" do
    @adjust_fee_info.adjust_fee = -(@adjust_fee_info.carrying_bill.carrying_fee + 10)
    @adjust_fee_info.should_not be_valid
  end

  it "信息上报后,其状态应为'已上报" do
    @adjust_fee_info.should be_submited
  end
  it "信息审批后,其状态应为'已审核" do
    old_fee = @adjust_fee_info.carrying_bill.carrying_fee
    puts old_fee
    puts @adjust_fee_info.adjust_fee
    @adjust_fee_info.pass
    @adjust_fee_info.should be_authorized
    #puts @adjust_fee_info.carrying_bill.carrying_fee
    #@adjust_fee_info.carrying_bill.carrying_fee.should == old_fee + @adjust_fee_info.adjust_fee
  end
  it "信息拒绝后,其状态应为'已驳回" do
    @adjust_fee_info.deny
    @adjust_fee_info.should be_denied
  end
end
