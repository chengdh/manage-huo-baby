# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe ReturnBillsController do
  login_admin
  render_views
  before(:each) do
    @bill = Factory(:computer_bill_reached)
  end

  describe "get before_new" do
    it "should be success" do
      get :before_new
      response.should be_success
    end
  end
  describe "get new" do
    it "should be success" do
      get :new,:search => {:bill_no_eq => @bill.bill_no}
      response.should be_success
    end
    it "should render :before_new if params[:search] or params[:search][:bill_no_eq] blank" do
      get :new
      response.should render_template(:before_new)
    end
  end
end

