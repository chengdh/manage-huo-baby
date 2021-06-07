# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CashPayInfosController do
  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
      Factory(:cash_pay_info_with_bills)
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
    it "assigns the requested cash_pay_info as @cash_pay_info" do
      p_list = Factory(:cash_pay_info_with_bills)
      get :show, :id => p_list
      assigns(:cash_pay_info).should == p_list
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
      @computer_bill = Factory(:computer_bill_payment_listed)
    end

    describe "with valid params" do
      it "success create cash_pay_info" do
        lambda do
          post :create,:cash_pay_info => {:org_id => Factory(:zz),:id_number => '412929197510020418',
                                          :account_no => '6222020210009876',:customer_name => "customer_name",
                                          :account_name => "张三",:mobile => '13676997527'},:bill_ids => [@computer_bill.id]
        end.should change(CashPayInfo,:count).by(1)
      end

      it "redirects to the created cash_pay_info" do
        post :create,:cash_pay_info => {:org_id => Factory(:zz),:id_number => '412929197510020418',
                                          :account_no => '6222020210009876',:customer_name => "customer_name",
                                          :account_name => "张三",:mobile => '13676997527'},:bill_ids => [@computer_bill.id]
 
        response.should redirect_to(assigns(:cash_pay_info))
      end
    end

    describe "with invalid params" do
      it "re-render the new 'template'" do
        post :create, :cash_pay_info => {}
        response.should render_template('new')
      end
    end
  end
end

