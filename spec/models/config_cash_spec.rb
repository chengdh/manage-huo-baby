# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ConfigCash do
  it "应能够正确获取系统默认手续费" do
    ConfigCash.cal_hand_fee(:goods_fee => 999).should == 1.0
    ConfigCash.cal_hand_fee(:goods_fee => 1000).should == 1.0
    ConfigCash.cal_hand_fee(:goods_fee => 2000).should == 2.0
    ConfigCash.cal_hand_fee(:goods_fee => 3000).should == 3.0
  end
  it "应能正确保存手续费设置" do
    config_cash = Factory.build(:config_cash)
    config_cash.save!
  end
end

