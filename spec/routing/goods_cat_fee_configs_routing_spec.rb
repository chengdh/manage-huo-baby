require "spec_helper"

describe GoodsCatFeeConfigsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/goods_cat_fee_configs" }.should route_to(:controller => "goods_cat_fee_configs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/goods_cat_fee_configs/new" }.should route_to(:controller => "goods_cat_fee_configs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/goods_cat_fee_configs/1" }.should route_to(:controller => "goods_cat_fee_configs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/goods_cat_fee_configs/1/edit" }.should route_to(:controller => "goods_cat_fee_configs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/goods_cat_fee_configs" }.should route_to(:controller => "goods_cat_fee_configs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/goods_cat_fee_configs/1" }.should route_to(:controller => "goods_cat_fee_configs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/goods_cat_fee_configs/1" }.should route_to(:controller => "goods_cat_fee_configs", :action => "destroy", :id => "1")
    end

  end
end
