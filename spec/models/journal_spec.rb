# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Journal do
  it "应能够正确保存 journal信息" do
    journal = Journal.new_with_org(Factory(:zz))
    journal.save!
  end
end

