# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CashPaymentListsController do
  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
      Factory(:cash_payment_list_with_bills)
      get :index
      response.should be_success
    end
  end

  describe "GET search" do
    it "should be success" do
      get :search
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested cash_payment_list as @cash_payment_list" do
      p_list = Factory(:cash_payment_list_with_bills)
      get :show, :id => p_list
      assigns(:cash_payment_list).should == p_list
    end
  end

  describe "GET new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    before(:each) do
      @computer_bill = Factory(:computer_bill_refounded_confirmed)
    end

    describe "with valid params" do
      it "success create cash_payment_list" do
        lambda do
          post :create,:cash_payment_list => {:org_id => Factory(:zz)},:bill_ids => [@computer_bill.id]
        end.should change(CashPaymentList,:count).by(1)
      end


      it "redirects to the created cash_payment_list" do
        post :create,:cash_payment_list => {:org_id => Factory(:zz)},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns(:cash_payment_list))
      end
    end

    describe "with invalid params" do
      it "re-render the new 'template'" do
        post :create, :cash_payment_list => {}
        response.should render_template('new')
      end
    end
  end
  #测试导出短信通知文本
  describe 'Get export_smx_txt' do
    it "should be success" do
      p_list = Factory(:cash_payment_list_with_bills)
      get :export_sms_txt,:id => p_list
    end
  end
end
