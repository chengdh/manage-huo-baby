require "spec_helper"

describe GoodsCatsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/goods_cats" }.should route_to(:controller => "goods_cats", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/goods_cats/new" }.should route_to(:controller => "goods_cats", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/goods_cats/1" }.should route_to(:controller => "goods_cats", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/goods_cats/1/edit" }.should route_to(:controller => "goods_cats", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/goods_cats" }.should route_to(:controller => "goods_cats", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/goods_cats/1" }.should route_to(:controller => "goods_cats", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/goods_cats/1" }.should route_to(:controller => "goods_cats", :action => "destroy", :id => "1")
    end

  end
end
