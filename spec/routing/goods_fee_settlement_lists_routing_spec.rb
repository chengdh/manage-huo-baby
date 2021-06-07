# -*- encoding : utf-8 -*-
require "spec_helper"

describe GoodsFeeSettlementListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/goods_fee_settlement_lists" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/goods_fee_settlement_lists/new" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/goods_fee_settlement_lists/1" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/goods_fee_settlement_lists/1/edit" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/goods_fee_settlement_lists" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/goods_fee_settlement_lists/1" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/goods_fee_settlement_lists/1" }.should route_to(:controller => "goods_fee_settlement_lists", :action => "destroy", :id => "1")
    end

  end
end

