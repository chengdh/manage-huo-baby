# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe SendListPostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/send_list_posts" }.should route_to(:controller => "send_list_posts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/send_list_posts/new" }.should route_to(:controller => "send_list_posts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/send_list_posts/1" }.should route_to(:controller => "send_list_posts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/send_list_posts/1/edit" }.should route_to(:controller => "send_list_posts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/send_list_posts" }.should route_to(:controller => "send_list_posts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/send_list_posts/1" }.should route_to(:controller => "send_list_posts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/send_list_posts/1" }.should route_to(:controller => "send_list_posts", :action => "destroy", :id => "1")
    end

  end
end

