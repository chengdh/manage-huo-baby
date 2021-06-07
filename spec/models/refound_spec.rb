# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Refound do
  before :each do
    @refound = Factory.build(:refound)
    @refound_with_bills = Factory(:refound_with_bills)
  end
  it "应能正确保存返款清单" do
    @refound.save!
  end
  it "处理后,返款清单状态应变为'已返款'" do
    @refound_with_bills.process
    @refound_with_bills.should be_refunded
    @refound_with_bills.carrying_bills.first.should be_refunded
  end
  it "收款确认处理后,返款清单状态应变为'已返款'" do
    @refound_with_bills.process
    @refound_with_bills.process
    @refound_with_bills.should be_refunded_confirmed
    @refound_with_bills.carrying_bills.first.should be_refunded_confirmed
  end

end

