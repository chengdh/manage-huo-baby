# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe SendListPost do
  it "应能够正确保存send list post" do
    Factory.build(:send_list_post).save!
  end
end

