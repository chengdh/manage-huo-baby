# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Bank do
  before(:each) do
    @bank_icbc = Factory.build(:icbc)
  end
  it "应能够成功保存银行信息" do 
    @bank_icbc.save!
  end
  it "保存时,必须录入名称和代码" do
    attrs = @bank_icbc.attributes.merge("code" => nil,"name" => nil)
    bank = Bank.new(attrs)
    bank.should_not be_valid
  end


end

