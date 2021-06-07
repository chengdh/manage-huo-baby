require "spec_helper"

describe HandInnerTransitBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/hand_inner_transit_bills").should route_to("hand_inner_transit_bills#index")
    end

    it "routes to #new" do
      get("/hand_inner_transit_bills/new").should route_to("hand_inner_transit_bills#new")
    end

    it "routes to #show" do
      get("/hand_inner_transit_bills/1").should route_to("hand_inner_transit_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hand_inner_transit_bills/1/edit").should route_to("hand_inner_transit_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hand_inner_transit_bills").should route_to("hand_inner_transit_bills#create")
    end

    it "routes to #update" do
      put("/hand_inner_transit_bills/1").should route_to("hand_inner_transit_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hand_inner_transit_bills/1").should route_to("hand_inner_transit_bills#destroy", :id => "1")
    end

  end
end
