# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Remittance do
  before :each do
    @remittance = Factory.build(:remittance)
  end
  it "应能正确保存汇款记录" do
    @remittance.save!
  end
  it "必须录入from_org to_org refound才能保存汇款信息" do
    attrs = @remittance.attributes.merge("from_org_id"=> nil,"to_org_id"=> nil, "refound"=> nil)
    remittance = Remittance.new(attrs)
    remittance.should_not be_valid
  end
end

