# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe CustomerLevelConfig do
  it "应能够正确却保存 customer_level_config 对象" do
    Factory.build(:customer_level_config).save!
  end
end

