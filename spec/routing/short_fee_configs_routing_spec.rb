require "spec_helper"

describe ShortFeeConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/short_fee_configs").should route_to("short_fee_configs#index")
    end

    it "routes to #new" do
      get("/short_fee_configs/new").should route_to("short_fee_configs#new")
    end

    it "routes to #show" do
      get("/short_fee_configs/1").should route_to("short_fee_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/short_fee_configs/1/edit").should route_to("short_fee_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/short_fee_configs").should route_to("short_fee_configs#create")
    end

    it "routes to #update" do
      put("/short_fee_configs/1").should route_to("short_fee_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/short_fee_configs/1").should route_to("short_fee_configs#destroy", :id => "1")
    end

  end
end
