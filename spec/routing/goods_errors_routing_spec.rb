# -*- encoding : utf-8 -*-
require "spec_helper"

describe GoodsErrorsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/goods_errors" }.should route_to(:controller => "goods_errors", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/goods_errors/new" }.should route_to(:controller => "goods_errors", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/goods_errors/1" }.should route_to(:controller => "goods_errors", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/goods_errors/1/edit" }.should route_to(:controller => "goods_errors", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/goods_errors" }.should route_to(:controller => "goods_errors", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/goods_errors/1" }.should route_to(:controller => "goods_errors", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/goods_errors/1" }.should route_to(:controller => "goods_errors", :action => "destroy", :id => "1")
    end
  end
end

