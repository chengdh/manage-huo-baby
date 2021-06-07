# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe RefoundsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/refounds" }.should route_to(:controller => "refounds", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/refounds/new" }.should route_to(:controller => "refounds", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/refounds/1" }.should route_to(:controller => "refounds", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/refounds/1/edit" }.should route_to(:controller => "refounds", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/refounds" }.should route_to(:controller => "refounds", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/refounds/1" }.should route_to(:controller => "refounds", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/refounds/1" }.should route_to(:controller => "refounds", :action => "destroy", :id => "1")
    end

  end
end

