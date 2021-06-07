# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe SendListsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/send_lists" }.should route_to(:controller => "send_lists", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/send_lists/new" }.should route_to(:controller => "send_lists", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/send_lists/1" }.should route_to(:controller => "send_lists", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/send_lists/1/edit" }.should route_to(:controller => "send_lists", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/send_lists" }.should route_to(:controller => "send_lists", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/send_lists/1" }.should route_to(:controller => "send_lists", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/send_lists/1" }.should route_to(:controller => "send_lists", :action => "destroy", :id => "1")
    end

  end
end

