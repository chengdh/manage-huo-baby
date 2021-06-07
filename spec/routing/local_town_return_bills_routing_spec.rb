require "spec_helper"

describe LocalTownReturnBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/local_town_return_bills").should route_to("local_town_return_bills#index")
    end

    it "routes to #new" do
      get("/local_town_return_bills/new").should route_to("local_town_return_bills#new")
    end

    it "routes to #show" do
      get("/local_town_return_bills/1").should route_to("local_town_return_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/local_town_return_bills/1/edit").should route_to("local_town_return_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/local_town_return_bills").should route_to("local_town_return_bills#create")
    end

    it "routes to #update" do
      put("/local_town_return_bills/1").should route_to("local_town_return_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/local_town_return_bills/1").should route_to("local_town_return_bills#destroy", :id => "1")
    end

  end
end
