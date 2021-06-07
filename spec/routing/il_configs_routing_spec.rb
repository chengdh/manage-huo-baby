# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe IlConfigsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/il_configs" }.should route_to(:controller => "il_configs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/il_configs/new" }.should route_to(:controller => "il_configs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/il_configs/1" }.should route_to(:controller => "il_configs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/il_configs/1/edit" }.should route_to(:controller => "il_configs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/il_configs" }.should route_to(:controller => "il_configs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/il_configs/1" }.should route_to(:controller => "il_configs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/il_configs/1" }.should route_to(:controller => "il_configs", :action => "destroy", :id => "1")
    end

  end
end

