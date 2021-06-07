# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GoodsFeeSettlementList do
  before(:each) do
    @goods_fee_settlement_list = Factory.build(:goods_fee_settlement_list)
  end
  it "应能够正确保存分理处货款结算清单" do
    @goods_fee_settlement_list.save!
  end
  it "分理处货款结算清单保存后,状态应变为'已过帐'" do
    @goods_fee_settlement_list.save!
    @goods_fee_settlement_list.post
    @goods_fee_settlement_list.reload
    @goods_fee_settlement_list.should be_posted
  end
end

