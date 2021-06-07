# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ReturnBill do
  before(:each) do
    @ori_bill = Factory(:computer_bill)
  end
  it "应能够正确保存退货运单" do
    @return_bill = ReturnBill.new_with_ori_bill(@ori_bill)
    @return_bill.save!
  end
  it "生成退回单后,相关数据应与原始运单相反" do
    @return_bill = ReturnBill.new_with_ori_bill(@ori_bill)
    @return_bill.bill_no.should be_include('TH')
    @return_bill.save!
    @return_bill.goods_no.should be_present
  end
end

