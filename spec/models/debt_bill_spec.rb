#coding: utf-8
require 'spec_helper'

describe DebtBill do
  it "应能正确保存debt_bill对象" do
    debt_bill = Factory.build(:debt_bill)
    debt_bill.save!
  end
  it "应能正确调用create_yesterday_debt_bills" do
    DebtBill.create_yesterday_debt_bills
  end
end
