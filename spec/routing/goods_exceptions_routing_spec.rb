# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe GoodsExceptionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/goods_exceptions" }.should route_to(:controller => "goods_exceptions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/goods_exceptions/new" }.should route_to(:controller => "goods_exceptions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/goods_exceptions/1" }.should route_to(:controller => "goods_exceptions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/goods_exceptions/1/edit" }.should route_to(:controller => "goods_exceptions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/goods_exceptions" }.should route_to(:controller => "goods_exceptions", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/goods_exceptions/1" }.should route_to(:controller => "goods_exceptions", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/goods_exceptions/1" }.should route_to(:controller => "goods_exceptions", :action => "destroy", :id => "1")
    end

  end
end

