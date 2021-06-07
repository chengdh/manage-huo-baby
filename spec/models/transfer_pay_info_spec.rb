# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransferPayInfo do
  before(:each) do
    @computer_bill = Factory(:computer_bill_payment_listed)
    @transfer_pay_info = Factory.build(:transfer_pay_info)
    @transfer_pay_info.carrying_bills << @computer_bill
  end
  it "应能够正确保存转账提款信息" do
    @transfer_pay_info.save!
  end
  it "转账提款清单保存后,其状态应变为'已提款'" do
    @transfer_pay_info.save!
    @transfer_pay_info.process
    @transfer_pay_info.reload
    @transfer_pay_info.should be_paid
    @computer_bill.reload
    @computer_bill.should be_paid
  end
end

