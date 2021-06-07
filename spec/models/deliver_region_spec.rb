#coding: utf-8
require 'spec_helper'

describe DeliverRegion do
  before :each do
    @deliver_region = Factory.build(:deliver_region)
  end
  it "应能够正确保存送货区域信息" do
    @deliver_region.save!
  end
end
