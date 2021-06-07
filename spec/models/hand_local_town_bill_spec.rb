#coding: utf-8
require 'spec_helper'

describe HandLocalTownBill do
  before(:each) do
    @hand_local_town_bill = Factory.build(:computer_bill)
  end
  it "应能够成功创建一张手工同城票据" do
    @hand_local_town.save!
  end

end
