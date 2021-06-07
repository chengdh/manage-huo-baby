#coding: utf-8
require 'spec_helper'

describe ShortFeeConfig do
  it "应能正确短途费设置信息" do
    Factory.build(:short_fee_config).save!
  end
end
