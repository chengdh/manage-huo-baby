# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Area do
  it "应能正确保存中转地信息" do
    Factory.build(:area).save!
  end

end

