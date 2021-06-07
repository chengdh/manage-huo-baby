# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe SendListBacksController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/send_list_backs" }.should route_to(:controller => "send_list_backs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/send_list_backs/new" }.should route_to(:controller => "send_list_backs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/send_list_backs/1" }.should route_to(:controller => "send_list_backs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/send_list_backs/1/edit" }.should route_to(:controller => "send_list_backs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/send_list_backs" }.should route_to(:controller => "send_list_backs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/send_list_backs/1" }.should route_to(:controller => "send_list_backs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/send_list_backs/1" }.should route_to(:controller => "send_list_backs", :action => "destroy", :id => "1")
    end

  end
end

