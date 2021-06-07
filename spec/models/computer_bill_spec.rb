# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ComputerBill do
  before(:each) do
    @computer_bill = Factory.build(:computer_bill)
  end
  it "应能够成功创建一张机打票据" do
    @computer_bill.save!
  end
  it "机打票保存后应自动产生票据编号和货号" do
    @computer_bill.save!
    @computer_bill.bill_no.should_not be_blank
    @computer_bill.goods_no.should_not be_blank
  end
  it "客户编号与客户姓名不匹配时,验证不通过" do
    customer = Factory(:customer)
    @computer_bill.customer_code = '00001'
    @computer_bill.from_customer_name = 'test'
    @computer_bill.should_not be_valid
  end
  it "机打票必须录入发货地和到货地" do
    @computer_bill.from_org = nil
    @computer_bill.to_org = nil
    @computer_bill.should_not be_valid
  end
  it "票据初始状态应为'已开票'" do
    @computer_bill.should be_billed
  end
  it "票据进行装车后,状态应变为'已装车'" do
    load_list = Factory(:load_list)
    @computer_bill.load_list = load_list
    @computer_bill.standard_process
    @computer_bill.should be_loaded
  end
  it "票据进行发车操作后,其状态应被修改为'已发出'" do

    load_list = Factory(:load_list)

    @computer_bill.load_list = load_list
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.should be_shipped
  end
  it "票据进行到货确认操作后,其状态应被修改为'已到货'" do

    load_list = Factory(:load_list)

    @computer_bill.load_list = load_list
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.should be_reached
  end
  it "在已货物已到达状态下进行退货操作,则运单状态应被修改为'已退货状态'" do
    load_list = Factory(:load_list)

    @computer_bill.load_list = load_list

    @computer_bill.standard_process #装车
    @computer_bill.standard_process #发货
    @computer_bill.standard_process #到货
    @computer_bill.return
    @computer_bill.should be_returned
  end
  it "进行装车操作,如果运单的load_bill为空,则无法装车" do
    @computer_bill.standard_process
    @computer_bill.should_not be_loaded
  end

  it "应能够正确获取分理处货物滞留信息" do
    CarryingBill.bills_in_branch(1).explain.should_not be_blank
  end
  it "应能够正确获取货场货物滞留信息" do
    CarryingBill.bills_in_yard(1).explain.should_not be_blank
  end
  it "应能够正确统计盘货报表" do
    CarryingBill.bills_inventory_report(1).explain.should_not be_blank
  end
  it "应能正确统计欠款提货清单" do
    CarryingBill.debt_bills(1,'2013-11-14').explain.should_not be_blank
  end
  it "应能够正确计算预付款期初余额" do
    CarryingBill.prepay_entry_beginning_balance(1).explain.should_not be_blank 
  end
  it "应能够正确计算预付款合计费用" do
    CarryingBill.sum_by_pay_type_th.explain.should_not be_blank 
  end

end

