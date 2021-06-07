# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe SendListBack do
  it "应能够正确保存 send list back 对象" do
    Factory.build(:send_list_back).save!
  end

end

