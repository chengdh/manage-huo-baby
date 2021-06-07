# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe TransferPayInfosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/transfer_pay_infos" }.should route_to(:controller => "transfer_pay_infos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/transfer_pay_infos/new" }.should route_to(:controller => "transfer_pay_infos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/transfer_pay_infos/1" }.should route_to(:controller => "transfer_pay_infos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/transfer_pay_infos/1/edit" }.should route_to(:controller => "transfer_pay_infos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/transfer_pay_infos" }.should route_to(:controller => "transfer_pay_infos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/transfer_pay_infos/1" }.should route_to(:controller => "transfer_pay_infos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/transfer_pay_infos/1" }.should route_to(:controller => "transfer_pay_infos", :action => "destroy", :id => "1")
    end

  end
end

