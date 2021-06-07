#coding: utf-8
require 'spec_helper'

describe LoadListWithBarcode do
  before :each do
    @load_list_with_barcode = Factory.build(:load_list_with_barcode)
  end
  it "应能够正常保存条码装车清单" do
    @load_list_with_barcode.save!
  end
end
