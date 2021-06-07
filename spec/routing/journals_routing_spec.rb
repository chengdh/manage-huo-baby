# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe JournalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/journals" }.should route_to(:controller => "journals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/journals/new" }.should route_to(:controller => "journals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/journals/1" }.should route_to(:controller => "journals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/journals/1/edit" }.should route_to(:controller => "journals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/journals" }.should route_to(:controller => "journals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/journals/1" }.should route_to(:controller => "journals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/journals/1" }.should route_to(:controller => "journals", :action => "destroy", :id => "1")
    end

  end
end

