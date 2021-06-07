#coding: utf-8
require 'spec_helper'

describe LocalTownBill do
  before(:each) do
    @local_town_bill = Factory.build(:computer_bill)
  end
  it "应能够成功创建一张机打-同城票据" do
    @local_town.save!
  end
end
