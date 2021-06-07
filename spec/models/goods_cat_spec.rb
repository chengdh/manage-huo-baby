require 'spec_helper'

describe GoodsCat do
  before :each do
    @goods_cat = Factory.build(:goods_cat)
  end
  it "should saved success" do
    @goods_cat.save!
  end
end
