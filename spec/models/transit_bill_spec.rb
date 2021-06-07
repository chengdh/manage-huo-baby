# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransitBill do
  before(:each) do
    @transit_bill = Factory.build(:transit_bill)
  end
  it "应能够正确保存中转运单" do
    @transit_bill.save!
  end
  it "到货确认后,下一步操作应为'中转处理'" do
    @transit_bill.load_list_id = 1
    @transit_bill.transit_info_id = 1

    @transit_bill.standard_process  #装车
    @transit_bill.standard_process  #发货
    @transit_bill.standard_process  #到货
    @transit_bill.standard_process  #中转
    @transit_bill.should be_transited
  end
  it "中转处理后,下一步操作应为'已提货'" do
    @transit_bill.load_list_id = 1
    @transit_bill.transit_info_id = 1
    @transit_bill.transit_deliver_info_id = 1

    @transit_bill.standard_process  #装车
    @transit_bill.standard_process  #发货
    @transit_bill.standard_process  #到货
    @transit_bill.standard_process  #中转
    @transit_bill.standard_process  #提货
    @transit_bill.should be_deliveried
  end
  it "提货处理后,下一步操作应为'已日结'" do
    @transit_bill.load_list_id = 1
    @transit_bill.transit_info_id = 1
    @transit_bill.transit_deliver_info_id = 1
    @transit_bill.settlement_id = 1

    @transit_bill.standard_process  #装车
    @transit_bill.standard_process  #发货
    @transit_bill.standard_process  #到货
    @transit_bill.standard_process  #中转
    @transit_bill.standard_process  #提货
    @transit_bill.standard_process  #日结
    @transit_bill.should be_settlemented
  end
end

