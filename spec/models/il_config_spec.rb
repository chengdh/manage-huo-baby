# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe IlConfig do
  before :each do
    @il_config = Factory.build :il_config
  end
  it "应能够正确保存il config 信息" do
    @il_config.save!
  end
  it "必须录入key value 才能保存" do
    attrs = @il_config.attributes.merge("key" => nil,"value" =>"nil")

    il_config = IlConfig.new(attrs)
    il_config.should_not be_valid
  end
end

