#coding: utf-8
require 'spec_helper'

describe InnerTransitBill do
  before :each do
    @inner_transit_bill = Factory.build(:inner_transit_bill)
  end
   
  it "应能够成功创建一张内部中转运单" do
    @inner_transit_bill.save!
  end

  it "中转运单初始状态应为'已开票" do
    @inner_transit_bill.should be_billed
  end
  it "中转运单装车后,状态应变为'已装车" do
    load_list = Factory(:load_list)
    @inner_transit_bill.load_list = load_list
    #装车操作
    @inner_transit_bill.standard_process
    @inner_transit_bill.should be_loaded
  end
  it "中转运单确认发车后,状态应变为'在途" do
    load_list = Factory(:load_list)
    @inner_transit_bill.load_list = load_list
    #装车-发车
    (1..2).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_shipped
  end
  it "中转运单进行到货确认后,状态应变为'到达中转地" do
    load_list = Factory(:load_list)
    @inner_transit_bill.load_list = load_list
    #装车-发车-中转到货确认
    (1..3).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_transit_reached
  end
  it "中转运单进行中转地发货确认后,状态应变为'中转在途" do
    load_list = Factory(:load_list)
    @inner_transit_bill.load_list = load_list
    #装车-发车-中转到货确认-中转发货
    (1..4).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_transit_shipped
  end
  it "中转运单进行到货确认操作后,状态应变为'已到货" do
    load_list = Factory(:load_list)
    @inner_transit_bill.load_list = load_list
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..5).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_reached
  end
  it "中转运单进行分货操作后,状态应变为'已分货" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..6).each {@inner_transit_bill.standard_process}
    puts @inner_transit_bill.state
    @inner_transit_bill.should be_distributed
  end
  it "中转运单进行提货操作后,状态应变为'已提货" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..7).each {@inner_transit_bill.standard_process}

    @inner_transit_bill.should be_deliveried
  end
  it "中转运单进行结算操作后,状态应变为'已日结" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
 
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..8).each {@inner_transit_bill.standard_process}

    @inner_transit_bill.should be_settlemented
  end
  it "中转运单进行返款操作后,状态应变为'已返款" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
    @inner_transit_bill.refound_id = 1
 
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..9).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_refunded
  end

  it "中转运单进行返款确认操作后,状态应变为'返款已确认(中转)" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
    @inner_transit_bill.refound_id = 1
 
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..10).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_transit_refunded_confirmed
  end
  it "中转运单进行发货地返款确认操作后,状态应变为'返款已确认" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
    @inner_transit_bill.refound_id = 1
 

    #装车-发车-中转到货确认-中转发货-到货确认
    (1..11).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_refunded_confirmed
  end

  it "中转运单进行代收货款支付清单操作后,状态应变为'准备支付'" do
    #NOTE 为避免测试失败,添加了相关字段的值
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
    @inner_transit_bill.refound_id = 1
    @inner_transit_bill.payment_list_id = 1
 
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..12).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_payment_listed
  end

  it "中转运单进行代收货款支付操作后,状态应变为'货款已支付支付'" do
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
    @inner_transit_bill.refound_id = 1
    @inner_transit_bill.payment_list_id = 1
    @inner_transit_bill.pay_info_id = 1
 
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..13).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_paid
  end
  it "中转运单进行结账操作后,状态应变为'已过账" do
    @inner_transit_bill.distribution_list_id = 1
    @inner_transit_bill.load_list_id = 1
    @inner_transit_bill.deliver_info_id = 1
    @inner_transit_bill.settlement_id = 1
    @inner_transit_bill.refound_id = 1
    @inner_transit_bill.payment_list_id = 1
    @inner_transit_bill.pay_info_id = 1
    @inner_transit_bill.post_info_id = 1
 
    #装车-发车-中转到货确认-中转发货-到货确认
    (1..14).each {@inner_transit_bill.standard_process}
    @inner_transit_bill.should be_posted
    @inner_transit_bill.should be_completed
  end
end
