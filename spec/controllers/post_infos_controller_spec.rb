# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe PostInfosController do
  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
      Factory(:post_info_with_bills)
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
    it "assigns the requested post_info as @post_info" do
      p_list = Factory(:post_info_with_bills)
      get :show, :id => p_list
      assigns(:post_info).should == p_list
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
      @computer_bill = Factory(:computer_bill_paid)
    end

    describe "with valid params" do
      it "success create post_info" do
        lambda do
          post :create,:post_info => {:org_id => Factory(:zz)},:bill_ids => [@computer_bill.id]
        end.should change(PostInfo,:count).by(1)
      end

      it "redirects to the created post_info" do
        post :create,:post_info => {:org_id => Factory(:zz)},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns(:post_info))
      end
    end

    describe "with invalid params" do
      it "re-render the new 'template'" do
        post :create, :post_info => {}
        response.should render_template('new')
      end
    end
  end
end

