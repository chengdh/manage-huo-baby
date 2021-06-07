# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe CarryingBillsController do
  login_admin
  render_views

  describe "GET index" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end

    it "assigns all computer_bills as @computer_bills" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end


    it "should be success" do
      get :show, :id => @computer_bill
      response.should be_success
    end

    it "assigns the requested computer_bill as @computer_bill" do
      get :show, :id => @computer_bill
      response.should render_template('show')
    end
  end
  #测试外部查询运单服务
  describe "GET search_service_page" do
    it "should be success" do
      get :search_service_page
      response.should be_success
    end
  end
  #测试多运单查询功能
  describe "GET multi_bills_search" do
    it "should be success" do
      get :multi_bills_search
      response.should be_success
    end
  end
  #测试按照客户编号查询运单功能
  describe "GET customer_code_search" do
    it "should be success" do
      get :customer_code_search
      response.should be_success
    end
  end
  #测试运单注销cancel功能
  describe "PUT carrying_bill/:id/cancel" do
    it "shoud cancel current bill" do
      @carrying_bill = Factory(:computer_bill_reached)
      put :cancel,:id => @carrying_bill
      assigns[:carrying_bill].should be_canceled
    end
  end
  #测试运单批量删除功能
  describe "DELETE carrying_bills/batch_destroy" do
    it "应该能够成功删除多条运单信息" do
      bills = [Factory(:computer_bill).id,Factory(:hand_bill).id]
      request.env["HTTP_REFERER"]=carrying_bills_path
      lambda do
        delete :batch_destroy, :bill_ids => bills,:format => :js
      end.should change(CarryingBill,:count).by(-2)
    end
  end
  #测试始发地收货汇总表
  describe "GET carrying_bills/rpt_turnover_by_from_org" do
    it "should success" do
      get :rpt_turnover_by_from_org,"search[type_in]" => ["ComputerBill","HandBill","ReturnBill","AutoCalculateComputerBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day
      response.should be_success
    end
  end
end

