# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe CustomersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/customers" }.should route_to(:controller => "customers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/customers/new" }.should route_to(:controller => "customers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/customers/1" }.should route_to(:controller => "customers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/customers/1/edit" }.should route_to(:controller => "customers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/customers" }.should route_to(:controller => "customers", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/customers/1" }.should route_to(:controller => "customers", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/customers/1" }.should route_to(:controller => "customers", :action => "destroy", :id => "1")
    end

  end
end

