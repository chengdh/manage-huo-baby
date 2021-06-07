require "spec_helper"

describe AdjustGoodsFeeInfosController do
  describe "routing" do

    it "routes to #index" do
      get("/adjust_goods_fee_infos").should route_to("adjust_goods_fee_infos#index")
    end

    it "routes to #new" do
      get("/adjust_goods_fee_infos/new").should route_to("adjust_goods_fee_infos#new")
    end

    it "routes to #show" do
      get("/adjust_goods_fee_infos/1").should route_to("adjust_goods_fee_infos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/adjust_goods_fee_infos/1/edit").should route_to("adjust_goods_fee_infos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/adjust_goods_fee_infos").should route_to("adjust_goods_fee_infos#create")
    end

    it "routes to #update" do
      put("/adjust_goods_fee_infos/1").should route_to("adjust_goods_fee_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/adjust_goods_fee_infos/1").should route_to("adjust_goods_fee_infos#destroy", :id => "1")
    end

  end
end
