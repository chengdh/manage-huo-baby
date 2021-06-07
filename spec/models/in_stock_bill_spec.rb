#coding: utf-8
require 'spec_helper'

describe InStockBill do
  it "应能正常保存实际未提货物清单" do
    isb = Factory.build(:in_stock_bill)
    isb.save!
  end
end
