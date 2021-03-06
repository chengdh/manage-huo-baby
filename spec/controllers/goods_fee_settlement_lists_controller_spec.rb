# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe GoodsFeeSettlementListsController do
  login_admin
  render_views

  describe "GET index" do
    it "should be success" do
      Factory(:goods_fee_settlement_list)
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
    it "assigns the requested goods_fee_settlement_list as @goods_fee_settlement_list" do
      gfs_list = Factory(:goods_fee_settlement_list)
      get :show, :id => gfs_list
      assigns(:goods_fee_settlement_list).should == gfs_list
    end
  end

  describe "GET new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end
end

