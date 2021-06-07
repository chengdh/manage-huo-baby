# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe DistributionListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/distribution_lists" }.should route_to(:controller => "distribution_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/distribution_lists/new" }.should route_to(:controller => "distribution_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/distribution_lists/1" }.should route_to(:controller => "distribution_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/distribution_lists/1/edit" }.should route_to(:controller => "distribution_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/distribution_lists" }.should route_to(:controller => "distribution_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/distribution_lists/1" }.should route_to(:controller => "distribution_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/distribution_lists/1" }.should route_to(:controller => "distribution_lists", :action => "destroy", :id => "1")
    end

  end
end

