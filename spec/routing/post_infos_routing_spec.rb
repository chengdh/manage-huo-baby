# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe PostInfosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/post_infos" }.should route_to(:controller => "post_infos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/post_infos/new" }.should route_to(:controller => "post_infos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/post_infos/1" }.should route_to(:controller => "post_infos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/post_infos/1/edit" }.should route_to(:controller => "post_infos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/post_infos" }.should route_to(:controller => "post_infos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/post_infos/1" }.should route_to(:controller => "post_infos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/post_infos/1" }.should route_to(:controller => "post_infos", :action => "destroy", :id => "1")
    end

  end
end

