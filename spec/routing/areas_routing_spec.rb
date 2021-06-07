# -*- encoding : utf-8 -*-
require "spec_helper"

describe AreasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/areas" }.should route_to(:controller => "areas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/areas/new" }.should route_to(:controller => "areas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/areas/1" }.should route_to(:controller => "areas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/areas/1/edit" }.should route_to(:controller => "areas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/areas" }.should route_to(:controller => "areas", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/areas/1" }.should route_to(:controller => "areas", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/areas/1" }.should route_to(:controller => "areas", :action => "destroy", :id => "1")
    end

  end
end

