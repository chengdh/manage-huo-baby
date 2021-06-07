# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe LoadListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/load_lists" }.should route_to(:controller => "load_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/load_lists/new" }.should route_to(:controller => "load_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/load_lists/1" }.should route_to(:controller => "load_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/load_lists/1/edit" }.should route_to(:controller => "load_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/load_lists" }.should route_to(:controller => "load_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/load_lists/1" }.should route_to(:controller => "load_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/load_lists/1" }.should route_to(:controller => "load_lists", :action => "destroy", :id => "1")
    end

  end
end

