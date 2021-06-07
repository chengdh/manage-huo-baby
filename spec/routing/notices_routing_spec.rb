require "spec_helper"

describe NoticesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/notices" }.should route_to(:controller => "notices", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/notices/new" }.should route_to(:controller => "notices", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/notices/1" }.should route_to(:controller => "notices", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/notices/1/edit" }.should route_to(:controller => "notices", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/notices" }.should route_to(:controller => "notices", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/notices/1" }.should route_to(:controller => "notices", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/notices/1" }.should route_to(:controller => "notices", :action => "destroy", :id => "1")
    end

  end
end
