# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe SettlementsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/settlements" }.should route_to(:controller => "settlements", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/settlements/new" }.should route_to(:controller => "settlements", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/settlements/1" }.should route_to(:controller => "settlements", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/settlements/1/edit" }.should route_to(:controller => "settlements", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/settlements" }.should route_to(:controller => "settlements", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/settlements/1" }.should route_to(:controller => "settlements", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/settlements/1" }.should route_to(:controller => "settlements", :action => "destroy", :id => "1")
    end

  end
end

