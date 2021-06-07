# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CashPaymentList do
  before(:each) do
    @computer_bill = Factory(:computer_bill_refounded_confirmed)
    @cash_payment_list = Factory.build(:cash_payment_list_with_bills)
    @cash_payment_list.carrying_bills << @computer_bill
  end
  it "应能够正确保存现金代收货款转账清单" do
    @cash_payment_list.save!
  end
  it "应能够正确导出短信通知文本" do
    @cash_payment_list.export_sms_txt.should_not be_blank
  end
  it "org_id 不可为空" do
    @cash_payment_list.org_id = nil
    @cash_payment_list.should_not be_valid
  end
  it "保存后,其状态应为payment_listed" do
    @cash_payment_list.save!
    @cash_payment_list.process
    @cash_payment_list.reload
    @computer_bill.reload

    @cash_payment_list.should be_payment_listed
    @computer_bill.should be_payment_listed
  end
end

