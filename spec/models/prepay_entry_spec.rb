#coding: utf-8
#预付款凭证设置
require 'spec_helper'

describe PrepayEntry do
  before :each do
    @prepay_entry_new = Factory.build(:prepay_entry)
  end
  it "应能正确保存prepay_entry信息" do
    @prepay_entry_new.save!
  end
end
