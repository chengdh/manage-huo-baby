require "spec_helper"

describe PriceTablesController do
  describe "routing" do

    it "routes to #index" do
      get("/price_tables").should route_to("price_tables#index")
    end

    it "routes to #new" do
      get("/price_tables/new").should route_to("price_tables#new")
    end

    it "routes to #show" do
      get("/price_tables/1").should route_to("price_tables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/price_tables/1/edit").should route_to("price_tables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/price_tables").should route_to("price_tables#create")
    end

    it "routes to #update" do
      put("/price_tables/1").should route_to("price_tables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/price_tables/1").should route_to("price_tables#destroy", :id => "1")
    end

  end
end
