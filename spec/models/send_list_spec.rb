# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe SendList do
  it "应能正确保存send_list" do
    send_list = Factory.build(:send_list)
    send_list.send_list_lines << SendListLine.new(:carrying_bill => Factory(:computer_bill))
    send_list.save!
  end
end

