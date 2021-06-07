# -*- encoding : utf-8 -*-
#coding: utf-8
require "spec_helper"

describe BanksController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/banks" }.should route_to(:controller => "banks", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/banks/new" }.should route_to(:controller => "banks", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/banks/1" }.should route_to(:controller => "banks", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/banks/1/edit" }.should route_to(:controller => "banks", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/banks" }.should route_to(:controller => "banks", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/banks/1" }.should route_to(:controller => "banks", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/banks/1" }.should route_to(:controller => "banks", :action => "destroy", :id => "1")
    end
  end
end

