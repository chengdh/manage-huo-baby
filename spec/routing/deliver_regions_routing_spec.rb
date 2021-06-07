require "spec_helper"

describe DeliverRegionsController do
  describe "routing" do

    it "routes to #index" do
      get("/deliver_regions").should route_to("deliver_regions#index")
    end

    it "routes to #new" do
      get("/deliver_regions/new").should route_to("deliver_regions#new")
    end

    it "routes to #show" do
      get("/deliver_regions/1").should route_to("deliver_regions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deliver_regions/1/edit").should route_to("deliver_regions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deliver_regions").should route_to("deliver_regions#create")
    end

    it "routes to #update" do
      put("/deliver_regions/1").should route_to("deliver_regions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deliver_regions/1").should route_to("deliver_regions#destroy", :id => "1")
    end

  end
end
