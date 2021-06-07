# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransitDeliverInfo do
  before(:each) do
    @transit_deliver_info = Factory.build(:transit_deliver_info_with_bill)
  end
  it "应能够正确保存 transit_deliver_info 信息" do
    @transit_deliver_info.save!
  end

  it "中转提货信息保存后,其状态应变为 已提货" do
    @transit_deliver_info.save!
    @transit_deliver_info.process
    @transit_deliver_info.reload
    @transit_deliver_info.should be_deliveried
  end
end

