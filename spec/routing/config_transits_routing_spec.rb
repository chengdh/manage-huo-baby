# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe ConfigTransitsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/config_transits" }.should route_to(:controller => "config_transits", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/config_transits/new" }.should route_to(:controller => "config_transits", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/config_transits/1" }.should route_to(:controller => "config_transits", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/config_transits/1/edit" }.should route_to(:controller => "config_transits", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/config_transits" }.should route_to(:controller => "config_transits", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/config_transits/1" }.should route_to(:controller => "config_transits", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/config_transits/1" }.should route_to(:controller => "config_transits", :action => "destroy", :id => "1")
    end

  end
end

