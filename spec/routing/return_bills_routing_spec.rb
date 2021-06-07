# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe ReturnBillsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/return_bills" }.should route_to(:controller => "return_bills", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/return_bills/new" }.should route_to(:controller => "return_bills", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/return_bills/1" }.should route_to(:controller => "return_bills", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/return_bills/1/edit" }.should route_to(:controller => "return_bills", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/return_bills" }.should route_to(:controller => "return_bills", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/return_bills/1" }.should route_to(:controller => "return_bills", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/return_bills/1" }.should route_to(:controller => "return_bills", :action => "destroy", :id => "1")
    end

  end
end

