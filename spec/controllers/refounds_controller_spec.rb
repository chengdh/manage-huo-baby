# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe RefoundsController do
  login_admin
  render_views
  describe "GET index" do
    it "should be success" do
      Factory(:refound_with_bills)
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
    it "assigns the requested refound as @refound" do
      refound = Factory(:refound_with_bills)
      get :show, :id => refound
      assigns(:refound).should == refound
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
      @computer_bill = Factory(:computer_bill_settlemented)
    end

    describe "with valid params" do
      it "should success create refound" do
        lambda do
          post :create,:refound => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)},:bill_ids => [@computer_bill.id]
        end.should change(Refound,:count).by(1)
      end

      it "redirects to the created refound" do
        post :create,:refound => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns[:refound])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :refound => {}
        response.should render_template("new")
      end
    end
  end
  #启动流程处理
  describe "PUT process_handle" do
    before(:each) do
      @refound ||= Factory(:refound_with_bills)
    end
    it "refound state should refunded_confirmed" do
      put :process_handle,:id =>@refound 
      response.should redirect_to(assigns[:refound])
    end
  end
end

