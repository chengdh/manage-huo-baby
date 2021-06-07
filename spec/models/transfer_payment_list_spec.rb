# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransferPaymentList do
  before(:each) do
    @t_payment_list = Factory.build(:transfer_payment_list)
  end
  it "应能够正确保存转账清单" do
    @t_payment_list.save!
  end
end

