# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe TransitCompaniesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/transit_companies" }.should route_to(:controller => "transit_companies", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/transit_companies/new" }.should route_to(:controller => "transit_companies", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/transit_companies/1" }.should route_to(:controller => "transit_companies", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/transit_companies/1/edit" }.should route_to(:controller => "transit_companies", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/transit_companies" }.should route_to(:controller => "transit_companies", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/transit_companies/1" }.should route_to(:controller => "transit_companies", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/transit_companies/1" }.should route_to(:controller => "transit_companies", :action => "destroy", :id => "1")
    end

  end
end

