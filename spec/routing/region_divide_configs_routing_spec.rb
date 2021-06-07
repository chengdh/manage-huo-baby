require "spec_helper"

describe RegionDivideConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/region_divide_configs").should route_to("region_divide_configs#index")
    end

    it "routes to #new" do
      get("/region_divide_configs/new").should route_to("region_divide_configs#new")
    end

    it "routes to #show" do
      get("/region_divide_configs/1").should route_to("region_divide_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/region_divide_configs/1/edit").should route_to("region_divide_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/region_divide_configs").should route_to("region_divide_configs#create")
    end

    it "routes to #update" do
      put("/region_divide_configs/1").should route_to("region_divide_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/region_divide_configs/1").should route_to("region_divide_configs#destroy", :id => "1")
    end

  end
end
