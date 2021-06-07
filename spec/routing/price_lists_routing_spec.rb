require "spec_helper"

describe PriceListsController do
  describe "routing" do

    it "routes to #index" do
      get("/price_lists").should route_to("price_lists#index")
    end

    it "routes to #new" do
      get("/price_lists/new").should route_to("price_lists#new")
    end

    it "routes to #show" do
      get("/price_lists/1").should route_to("price_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/price_lists/1/edit").should route_to("price_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/price_lists").should route_to("price_lists#create")
    end

    it "routes to #update" do
      put("/price_lists/1").should route_to("price_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/price_lists/1").should route_to("price_lists#destroy", :id => "1")
    end

  end
end
