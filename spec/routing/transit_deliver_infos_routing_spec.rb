# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe TransitDeliverInfosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/transit_deliver_infos" }.should route_to(:controller => "transit_deliver_infos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/transit_deliver_infos/new" }.should route_to(:controller => "transit_deliver_infos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/transit_deliver_infos/1" }.should route_to(:controller => "transit_deliver_infos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/transit_deliver_infos/1/edit" }.should route_to(:controller => "transit_deliver_infos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/transit_deliver_infos" }.should route_to(:controller => "transit_deliver_infos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/transit_deliver_infos/1" }.should route_to(:controller => "transit_deliver_infos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/transit_deliver_infos/1" }.should route_to(:controller => "transit_deliver_infos", :action => "destroy", :id => "1")
    end

  end
end

