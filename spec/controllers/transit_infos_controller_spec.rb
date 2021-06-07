# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransitInfosController do
  login_admin
  render_views

  describe "GET index" do
    before(:each) do
      @transit_info ||= Factory(:transit_info_with_bill)
    end

    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    before(:each) do
      @transit_info ||= Factory(:transit_info_with_bill)
    end

    it "should render 'show'" do
      get :show, :id => @transit_info
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
      @transit_bill = Factory(:transit_bill_reached)
    end
    describe "with valid params" do
      it "the load_list should success create" do
        lambda do
          post :create,:transit_info => {:org_id => Factory(:zz),:transit_company_id => Factory(:transit_company)},:bill_ids=> [@transit_bill.id],:transit_carrying_fee_edit => [1.99],:transit_bill_no_edit => ['transit_bill_no'],:transit_to_phone_edit => ["231231231"]
        end.should change(TransitInfo,:count).by(1)
      end

      it "redirects to the created load_list" do
        post :create,:transit_info => {:org_id => Factory(:zz),:transit_carrying_fee => 100,:transit_company_id => Factory(:transit_company)},:bill_ids=> [@transit_bill.id],:transit_carrying_fee_edit => [1.99],:transit_bill_no_edit => ['transit_bill_no'],:transit_to_phone_edit => ["231231231"]
        response.should redirect_to(assigns[:transit_info])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create,:transit_info => {},:bill_ids=> [@transit_bill.id],:transit_carrying_fee_edit => [1.99],:transit_bill_no_edit => ['transit_bill_no'],:transit_to_phone_edit => ["231231231"]
        response.should render_template('new')
      end
    end
  end
end

