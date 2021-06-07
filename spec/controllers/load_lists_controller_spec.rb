# -*- encoding : utf-8 -*-
require 'spec_helper'

describe LoadListsController do
  login_admin
  render_views

  describe "GET index" do
    before(:each) do
      @load_list ||= Factory(:load_list_with_bills)
    end

    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    before(:each) do
      @load_list ||= Factory(:load_list_with_bills)
    end

    it "should render 'show'" do
      get :show, :id => @load_list
      response.should render_template('show')
    end
  end

  describe "GET new" do
    it "should be sucesss" do
      get :new
      response.should be_success
    end
    it "should render template 'new'" do
      get :new
      response.should render_template('new')
    end
  end

  describe "POST create" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end
    describe "with valid params" do
      it "the load_list should success create" do
        lambda do
          post :create,:load_list => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay),:bill_no => "bill_no"},:bill_ids=> [@computer_bill.id]
        end.should change(LoadList,:count).by(1)
      end

      it "redirects to the created load_list" do
        post :create,:load_list => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay),:bill_no => "bill_no"},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns[:load_list])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :load_list => {:bill_no => "bill_no"},:bill_ids => [@computer_bill.id]
        response.should render_template('new')
      end
    end
  end


  describe "DELETE destroy" do
    before(:each) do
      @load_list ||= Factory(:load_list_with_bills)
    end

    it "destroys the requested load_list" do
      lambda do
        delete :destroy ,:id => @load_list
      end.should change(LoadList,:count).by(-1)
    end

    it "redirects to the load_lists list" do
      delete :destroy, :id => @load_list
      response.should redirect_to(load_lists_url)
    end
  end
  #启动流程处理
  describe "PUT process_handle" do
    it "load_list state should become shipped" do
      @load_list ||= Factory(:load_list_with_bills)
      put :process_handle,:id =>@load_list
      response.should redirect_to(assigns[:load_list])
    end

    it "load_list state should become 'reached' after reach process" do
      shipped_list = Factory(:load_list_shipped)
      put :process_handle,:id =>shipped_list
      response.should redirect_to(assigns[:load_list])
    end
  end
  #创建实际装车清单
  describe "GET build act_load_list" do
    it "should be success" do
      @load_list ||= Factory(:load_list_with_bills)
      get :build_act_load_list,:id => @load_list
      response.should be_success
    end
  end
end

