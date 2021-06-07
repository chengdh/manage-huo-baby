# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GoodsError do
  before :each do
    @goods_error = Factory.build(:goods_error)
  end
  it "应能够正确保存多货少货信息" do
    @goods_error.save!
  end
end

