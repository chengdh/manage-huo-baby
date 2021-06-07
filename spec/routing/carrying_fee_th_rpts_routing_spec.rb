require "spec_helper"

describe CarryingFeeThRptsController do
  describe "routing" do

    it "routes to #index" do
      get("/carrying_fee_th_rpts").should route_to("carrying_fee_th_rpts#index")
    end

    it "routes to #new" do
      get("/carrying_fee_th_rpts/new").should route_to("carrying_fee_th_rpts#new")
    end

    it "routes to #show" do
      get("/carrying_fee_th_rpts/1").should route_to("carrying_fee_th_rpts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/carrying_fee_th_rpts/1/edit").should route_to("carrying_fee_th_rpts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/carrying_fee_th_rpts").should route_to("carrying_fee_th_rpts#create")
    end

    it "routes to #update" do
      put("/carrying_fee_th_rpts/1").should route_to("carrying_fee_th_rpts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/carrying_fee_th_rpts/1").should route_to("carrying_fee_th_rpts#destroy", :id => "1")
    end

  end
end
