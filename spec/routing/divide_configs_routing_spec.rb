require "spec_helper"

describe DivideConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/divide_configs").should route_to("divide_configs#index")
    end

    it "routes to #new" do
      get("/divide_configs/new").should route_to("divide_configs#new")
    end

    it "routes to #show" do
      get("/divide_configs/1").should route_to("divide_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/divide_configs/1/edit").should route_to("divide_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/divide_configs").should route_to("divide_configs#create")
    end

    it "routes to #update" do
      put("/divide_configs/1").should route_to("divide_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/divide_configs/1").should route_to("divide_configs#destroy", :id => "1")
    end

  end
end
