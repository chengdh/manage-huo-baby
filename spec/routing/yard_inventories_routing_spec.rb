require "spec_helper"

describe YardInventoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/yard_inventories").should route_to("yard_inventories#index")
    end

    it "routes to #new" do
      get("/yard_inventories/new").should route_to("yard_inventories#new")
    end

    it "routes to #show" do
      get("/yard_inventories/1").should route_to("yard_inventories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/yard_inventories/1/edit").should route_to("yard_inventories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/yard_inventories").should route_to("yard_inventories#create")
    end

    it "routes to #update" do
      put("/yard_inventories/1").should route_to("yard_inventories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/yard_inventories/1").should route_to("yard_inventories#destroy", :id => "1")
    end

  end
end
