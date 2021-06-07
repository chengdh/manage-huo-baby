require "spec_helper"

describe InStockBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/in_stock_bills").should route_to("in_stock_bills#index")
    end

    it "routes to #new" do
      get("/in_stock_bills/new").should route_to("in_stock_bills#new")
    end

    it "routes to #show" do
      get("/in_stock_bills/1").should route_to("in_stock_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/in_stock_bills/1/edit").should route_to("in_stock_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/in_stock_bills").should route_to("in_stock_bills#create")
    end

    it "routes to #update" do
      put("/in_stock_bills/1").should route_to("in_stock_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/in_stock_bills/1").should route_to("in_stock_bills#destroy", :id => "1")
    end

  end
end
