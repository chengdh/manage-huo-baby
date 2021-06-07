# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransferPaymentListsController do
  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
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
    it "assigns the requested transfer_payment_list as @transfer_payment_list" do
      p_list = Factory(:transfer_payment_list_with_bills)
      get :show, :id => p_list
      assigns(:transfer_payment_list).should == p_list
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
      it "success create transfer_payment_list" do
        lambda do
          post :create, :transfer_payment_list => {:org_id => Factory(:zz),:bank_id => Factory(:icbc).id},:bill_ids => [@computer_bill.id]
        end.should change(TransferPaymentList,:count).by(1)
      end

      it "redirects to the created transfer_payment_list" do

        post :create, :transfer_payment_list => {:org_id => Factory(:zz),:bank_id => Factory(:icbc).id},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns(:transfer_payment_list))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :transfer_payment_list => {}
        response.should render_template("new")
      end
    end
  end
end
