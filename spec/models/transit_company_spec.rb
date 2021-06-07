# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransitCompany do
  it "应能正确保存中转物流公司信息" do
    Factory.build(:transit_company).save!
  end
end

