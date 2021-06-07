# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ArriveLoadListsController do
  login_admin
  render_views
  #创建通知信息
  describe "GET build notice " do
    it "should be success" do
      @load_list ||= Factory(:load_list_with_bills)
      get :build_notice,:id => @load_list
      response.should be_success
    end
  end
  describe "GET show_export_sms" do
    it "should be success" do
      @load_list ||= Factory(:load_list_with_bills)
      get :show_export_sms,:id => @load_list,:bill_ids => [1,2]
      response.should be_success

    end
  end
end
