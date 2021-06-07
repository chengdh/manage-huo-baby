require "spec_helper"

describe InnerTransitBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/inner_transit_bills").should route_to("inner_transit_bills#index")
    end

    it "routes to #new" do
      get("/inner_transit_bills/new").should route_to("inner_transit_bills#new")
    end

    it "routes to #show" do
      get("/inner_transit_bills/1").should route_to("inner_transit_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inner_transit_bills/1/edit").should route_to("inner_transit_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inner_transit_bills").should route_to("inner_transit_bills#create")
    end

    it "routes to #update" do
      put("/inner_transit_bills/1").should route_to("inner_transit_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inner_transit_bills/1").should route_to("inner_transit_bills#destroy", :id => "1")
    end

  end
end
