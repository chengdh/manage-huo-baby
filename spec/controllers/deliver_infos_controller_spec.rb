# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe DeliverInfosController do

  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
      Factory(:deliver_info_with_bills)
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested deliver_info as @deliver_info" do
      deliver_info = Factory(:deliver_info_with_bills)
      get :show, :id => deliver_info
      assigns(:deliver_info).should == deliver_info
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
      @computer_bill = Factory(:computer_bill_distributed)
    end

    describe "with valid params" do
      it "should success create deliver_info" do
        lambda do
          attrs = Factory.build(:deliver_info).attributes
          attrs.delete("id")
          attrs.delete("type")
          post :create, :deliver_info => attrs,:bill_ids => [@computer_bill.id]
        end.should change(DeliverInfo,:count).by(1)
      end

      it "redirects to the created deliver_info" do
        attrs = Factory.build(:deliver_info).attributes
        attrs.delete("id")
        attrs.delete("type")

        post :create, :deliver_info => attrs,:bll_ids => [@computer_bill.id]
        response.should redirect_to(assigns[:deliver_info])
      end
    end
    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :deliver_info => {}
        response.should render_template("new")
      end
    end
  end
end

