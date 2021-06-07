# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
require "spec_helper"

describe CashPayInfosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/cash_pay_infos" }.should route_to(:controller => "cash_pay_infos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cash_pay_infos/new" }.should route_to(:controller => "cash_pay_infos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cash_pay_infos/1" }.should route_to(:controller => "cash_pay_infos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cash_pay_infos/1/edit" }.should route_to(:controller => "cash_pay_infos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cash_pay_infos" }.should route_to(:controller => "cash_pay_infos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/cash_pay_infos/1" }.should route_to(:controller => "cash_pay_infos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cash_pay_infos/1" }.should route_to(:controller => "cash_pay_infos", :action => "destroy", :id => "1")
    end

  end
end

