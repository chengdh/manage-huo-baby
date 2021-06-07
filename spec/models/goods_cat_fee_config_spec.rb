require 'spec_helper'

describe GoodsCatFeeConfig do
  before :each do
    @goods_cat_fee_config = Factory.build(:goods_cat_fee_config)
    @goods_cat_fee_config.goods_cat_fee_config_lines << Factory.build(:goods_cat_fee_config_line)
  end
  it "should save goods_cat_fee_config success" do
    @goods_cat_fee_config.save!
  end
end
