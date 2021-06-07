#coding: utf-8
require 'spec_helper'

describe LoadListWithBarcodeLine do
  before :each do
    @line = Factory.build(:load_list_with_barcode_line)
  end
  it "应能正确保存条码装车明细" do
    @line.save!
  end
end
