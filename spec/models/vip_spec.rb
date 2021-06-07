#coding: utf-8
require 'spec_helper'

describe Vip do
  before(:each) do 
    @vip = Factory.build(:vip)
  end
  it "应能够正确保存vip信息" do
    @vip.save!
  end
  it "保存后,应能够正确生成vip code" do
    @vip.save!
    @vip.code.should be_present
  end

end

