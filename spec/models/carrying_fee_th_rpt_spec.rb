#coding: utf-8
#测试实提运费报表
require 'spec_helper'

describe CarryingFeeThRpt do
  before :each do
    @carrying_fee_th_rpt = Factory(:carrying_fee_th_rpt)
  end

  it "应能正确保存实提运费报表" do
    @carrying_fee_th_rpt.save!
  end
end
