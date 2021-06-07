# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Sender do
  it "应能够正确保存sender信息" do
    sender = Factory.build(:sender)
    sender.save!
  end
end

