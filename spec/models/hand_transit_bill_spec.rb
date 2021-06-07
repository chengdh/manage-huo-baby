# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HandTransitBill do
  before(:each) do
    @hand_transit_bill = Factory.build(:hand_transit_bill)
  end
  it "应能够成功创建一张手工中转票据" do
    @hand_transit_bill.save!
  end
end

