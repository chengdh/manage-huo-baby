# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe BranchesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/branches" }.should route_to(:controller => "branches", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/branches/new" }.should route_to(:controller => "branches", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/branches/1" }.should route_to(:controller => "branches", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/branches/1/edit" }.should route_to(:controller => "branches", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/branches" }.should route_to(:controller => "branches", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/branches/1" }.should route_to(:controller => "branches", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/branches/1" }.should route_to(:controller => "branches", :action => "destroy", :id => "1")
    end

  end
end

