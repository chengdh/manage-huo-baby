require "spec_helper"

describe TonVolumeBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/ton_volume_bills").should route_to("ton_volume_bills#index")
    end

    it "routes to #new" do
      get("/ton_volume_bills/new").should route_to("ton_volume_bills#new")
    end

    it "routes to #show" do
      get("/ton_volume_bills/1").should route_to("ton_volume_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ton_volume_bills/1/edit").should route_to("ton_volume_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ton_volume_bills").should route_to("ton_volume_bills#create")
    end

    it "routes to #update" do
      put("/ton_volume_bills/1").should route_to("ton_volume_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ton_volume_bills/1").should route_to("ton_volume_bills#destroy", :id => "1")
    end

  end
end
