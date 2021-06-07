# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe SettlementsController do
  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
      Factory(:settlement_with_bills)
      get :index
      response.should be_success
    end
  end

  describe "Get search" do
    it "should be success" do
      get :search
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested settlement as @settlement" do
      settlement = Factory(:settlement_with_bills)
      get :show, :id => settlement
      assigns(:settlement).should == settlement
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
      @computer_bill = Factory(:computer_bill_deliveried)
    end

    describe "with valid params" do
      it "should success create settlement" do
        lambda do
          post :create,:settlement => {:org_id => Factory(:zz)},:bill_ids => [@computer_bill.id]
        end.should change(Settlement,:count).by(1)
      end

      it "redirects to the created settlement" do

        post :create,:settlement => {:org_id => Factory(:zz)},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns[:settlement])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :settlement => {}
        response.should render_template("new")
      end
    end

  end
end

