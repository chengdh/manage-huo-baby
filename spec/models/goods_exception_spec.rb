# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe GoodsException do
  before :each do
    @goods_exception = Factory.build(:goods_exception)
  end
  it "应能够正确保存货物异常信息" do
    @goods_exception.save!
  end
end

