# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe CashPayInfo do
  before(:each) do
    @computer_bill = Factory(:computer_bill_payment_listed)
    @cash_pay_info = Factory.build(:cash_pay_info)
    @cash_pay_info.carrying_bills << @computer_bill
  end
  it "应能够正确保存现金提款信息" do
    @cash_pay_info.save!
  end
  it "现金提款清单保存后,其状态应变为'已提款'" do
    @cash_pay_info.save!
    @cash_pay_info.process
    @cash_pay_info.reload
    @cash_pay_info.should be_paid
    @computer_bill.reload
    @computer_bill.should be_paid
  end
end

