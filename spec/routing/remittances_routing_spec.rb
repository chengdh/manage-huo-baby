# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe RemittancesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/remittances" }.should route_to(:controller => "remittances", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/remittances/new" }.should route_to(:controller => "remittances", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/remittances/1" }.should route_to(:controller => "remittances", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/remittances/1/edit" }.should route_to(:controller => "remittances", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/remittances" }.should route_to(:controller => "remittances", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/remittances/1" }.should route_to(:controller => "remittances", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/remittances/1" }.should route_to(:controller => "remittances", :action => "destroy", :id => "1")
    end

  end
end

