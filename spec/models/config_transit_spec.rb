# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ConfigTransit do
  before :each do
    @config_transit = Factory.build(:config_transit)
  end
  it "应能正确保存转账手续费用信息" do
    @config_transit.save!
  end
  it "必须录入费率,否则不能保存" do
    attrs = @config_transit.attributes.merge("rate" => nil)
    config = ConfigTransit.new(attrs)
    config.should_not be_valid
  end
end

