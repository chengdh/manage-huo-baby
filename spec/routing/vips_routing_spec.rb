# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe VipsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/vips" }.should route_to(:controller => "vips", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/vips/new" }.should route_to(:controller => "vips", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/vips/1" }.should route_to(:controller => "vips", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/vips/1/edit" }.should route_to(:controller => "vips", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/vips" }.should route_to(:controller => "vips", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/vips/1" }.should route_to(:controller => "vips", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/vips/1" }.should route_to(:controller => "vips", :action => "destroy", :id => "1")
    end

  end
end

