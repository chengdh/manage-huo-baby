# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe SendersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/senders" }.should route_to(:controller => "senders", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/senders/new" }.should route_to(:controller => "senders", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/senders/1" }.should route_to(:controller => "senders", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/senders/1/edit" }.should route_to(:controller => "senders", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/senders" }.should route_to(:controller => "senders", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/senders/1" }.should route_to(:controller => "senders", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/senders/1" }.should route_to(:controller => "senders", :action => "destroy", :id => "1")
    end

  end
end

