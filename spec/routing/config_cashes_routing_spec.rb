# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe ConfigCashesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/config_cashes" }.should route_to(:controller => "config_cashes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/config_cashes/new" }.should route_to(:controller => "config_cashes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/config_cashes/1" }.should route_to(:controller => "config_cashes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/config_cashes/1/edit" }.should route_to(:controller => "config_cashes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/config_cashes" }.should route_to(:controller => "config_cashes", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/config_cashes/1" }.should route_to(:controller => "config_cashes", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/config_cashes/1" }.should route_to(:controller => "config_cashes", :action => "destroy", :id => "1")
    end

  end
end

