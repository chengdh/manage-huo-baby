# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransitInfo do
  before(:each) do
    @transit_info = Factory.build(:transit_info_with_bill)
  end
  it "应能够正确保存现金提款信息" do
    @transit_info.save!
  end
  it "中转信息保存后,其状态应变为'已中转'" do
    @transit_info.save!
    @transit_info.process
    @transit_info.reload
    @transit_info.should be_transited
  end
end

