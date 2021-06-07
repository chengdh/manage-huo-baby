require "spec_helper"

describe FromShortFeeInfosController do
  describe "routing" do

    it "routes to #index" do
      get("/from_short_fee_infos").should route_to("from_short_fee_infos#index")
    end

    it "routes to #new" do
      get("/from_short_fee_infos/new").should route_to("from_short_fee_infos#new")
    end

    it "routes to #show" do
      get("/from_short_fee_infos/1").should route_to("from_short_fee_infos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/from_short_fee_infos/1/edit").should route_to("from_short_fee_infos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/from_short_fee_infos").should route_to("from_short_fee_infos#create")
    end

    it "routes to #update" do
      put("/from_short_fee_infos/1").should route_to("from_short_fee_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/from_short_fee_infos/1").should route_to("from_short_fee_infos#destroy", :id => "1")
    end

  end
end
