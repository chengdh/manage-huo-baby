# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HandBill do
  before(:each) do
    @hand_bill = Factory.build(:computer_bill)
  end
  it "应能够成功创建一张手工票据" do
    @hand_bill.save!
  end
end

