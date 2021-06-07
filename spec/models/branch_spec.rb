# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Branch do
  before(:each) do
    @attr = Factory.attributes_for(:branch)
  end
  it "应能够成功新建机构信息" do
    Branch.create!(@attr)
  end
  it "必须录入机构名称才能保存" do
    no_name_org = Branch.new(@attr.merge(:name => ""))
    no_name_org.should_not be_valid
  end
  it "应能够自动生成拼音简写" do
    org = Branch.create!(@attr.merge(:name => "郑州"))
    org.py.should == 'zz'
  end

end

