require "spec_helper"

describe BranchInventoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/branch_inventories").should route_to("branch_inventories#index")
    end

    it "routes to #new" do
      get("/branch_inventories/new").should route_to("branch_inventories#new")
    end

    it "routes to #show" do
      get("/branch_inventories/1").should route_to("branch_inventories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/branch_inventories/1/edit").should route_to("branch_inventories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/branch_inventories").should route_to("branch_inventories#create")
    end

    it "routes to #update" do
      put("/branch_inventories/1").should route_to("branch_inventories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/branch_inventories/1").should route_to("branch_inventories#destroy", :id => "1")
    end

  end
end
