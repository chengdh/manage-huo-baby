require "spec_helper"

describe DepositsController do
  describe "routing" do

    it "routes to #index" do
      get("/deposits").should route_to("deposits#index")
    end

    it "routes to #new" do
      get("/deposits/new").should route_to("deposits#new")
    end

    it "routes to #show" do
      get("/deposits/1").should route_to("deposits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deposits/1/edit").should route_to("deposits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deposits").should route_to("deposits#create")
    end

    it "routes to #update" do
      put("/deposits/1").should route_to("deposits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deposits/1").should route_to("deposits#destroy", :id => "1")
    end

  end
end
