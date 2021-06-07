require "spec_helper"

describe FeeUnitsController do
  describe "routing" do

    it "routes to #index" do
      get("/fee_units").should route_to("fee_units#index")
    end

    it "routes to #new" do
      get("/fee_units/new").should route_to("fee_units#new")
    end

    it "routes to #show" do
      get("/fee_units/1").should route_to("fee_units#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fee_units/1/edit").should route_to("fee_units#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fee_units").should route_to("fee_units#create")
    end

    it "routes to #update" do
      put("/fee_units/1").should route_to("fee_units#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fee_units/1").should route_to("fee_units#destroy", :id => "1")
    end

  end
end
