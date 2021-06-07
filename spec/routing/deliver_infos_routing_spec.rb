# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe DeliverInfosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/deliver_infos" }.should route_to(:controller => "deliver_infos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/deliver_infos/new" }.should route_to(:controller => "deliver_infos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/deliver_infos/1" }.should route_to(:controller => "deliver_infos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/deliver_infos/1/edit" }.should route_to(:controller => "deliver_infos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/deliver_infos" }.should route_to(:controller => "deliver_infos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/deliver_infos/1" }.should route_to(:controller => "deliver_infos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/deliver_infos/1" }.should route_to(:controller => "deliver_infos", :action => "destroy", :id => "1")
    end

  end
end

