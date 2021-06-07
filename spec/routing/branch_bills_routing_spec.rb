require "spec_helper"

describe BranchBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/branch_bills").should route_to("branch_bills#index")
    end

    it "routes to #new" do
      get("/branch_bills/new").should route_to("branch_bills#new")
    end

    it "routes to #show" do
      get("/branch_bills/1").should route_to("branch_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/branch_bills/1/edit").should route_to("branch_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/branch_bills").should route_to("branch_bills#create")
    end

    it "routes to #update" do
      put("/branch_bills/1").should route_to("branch_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/branch_bills/1").should route_to("branch_bills#destroy", :id => "1")
    end

  end
end
