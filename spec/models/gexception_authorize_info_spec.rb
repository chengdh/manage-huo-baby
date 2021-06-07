# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe GexceptionAuthorizeInfo do
  before :each do 
    @gexception_authorize_info ||= Factory.build(:gexception_authorize_info)
  end

  it "应能够正确保存 gexception_authorize_info 对象" do
    @gexception_authorize_info.save!
  end
end

