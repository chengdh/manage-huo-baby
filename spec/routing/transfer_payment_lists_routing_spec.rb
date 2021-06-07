# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe TransferPaymentListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/transfer_payment_lists" }.should route_to(:controller => "transfer_payment_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/transfer_payment_lists/new" }.should route_to(:controller => "transfer_payment_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/transfer_payment_lists/1" }.should route_to(:controller => "transfer_payment_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/transfer_payment_lists/1/edit" }.should route_to(:controller => "transfer_payment_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/transfer_payment_lists" }.should route_to(:controller => "transfer_payment_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/transfer_payment_lists/1" }.should route_to(:controller => "transfer_payment_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/transfer_payment_lists/1" }.should route_to(:controller => "transfer_payment_lists", :action => "destroy", :id => "1")
    end

  end
end

