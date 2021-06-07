# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe DepartmentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/departments" }.should route_to(:controller => "departments", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/departments/new" }.should route_to(:controller => "departments", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/departments/1" }.should route_to(:controller => "departments", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/departments/1/edit" }.should route_to(:controller => "departments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/departments" }.should route_to(:controller => "departments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/departments/1" }.should route_to(:controller => "departments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/departments/1" }.should route_to(:controller => "departments", :action => "destroy", :id => "1")
    end

  end
end

