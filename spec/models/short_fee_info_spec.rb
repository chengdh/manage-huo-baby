# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ShortFeeInfo do
  before :each do
    @short_fee_info ||= Factory.build(:short_fee_info)
  end
  it "应能够正确保存short fee info" do
    @short_fee_info.save!
  end
end

