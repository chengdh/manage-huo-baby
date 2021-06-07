# -*- encoding : utf-8 -*-
require "spec_helper"

describe NotifiesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/notifies" }.should route_to(:controller => "notifies", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/notifies/new" }.should route_to(:controller => "notifies", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/notifies/1" }.should route_to(:controller => "notifies", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/notifies/1/edit" }.should route_to(:controller => "notifies", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/notifies" }.should route_to(:controller => "notifies", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/notifies/1" }.should route_to(:controller => "notifies", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/notifies/1" }.should route_to(:controller => "notifies", :action => "destroy", :id => "1")
    end

  end
end

