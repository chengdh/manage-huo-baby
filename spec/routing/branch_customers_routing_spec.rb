require "spec_helper"

describe BranchCustomersController do
  describe "routing" do

    it "routes to #index" do
      get("/branch_customers").should route_to("branch_customers#index")
    end

    it "routes to #new" do
      get("/branch_customers/new").should route_to("branch_customers#new")
    end

    it "routes to #show" do
      get("/branch_customers/1").should route_to("branch_customers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/branch_customers/1/edit").should route_to("branch_customers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/branch_customers").should route_to("branch_customers#create")
    end

    it "routes to #update" do
      put("/branch_customers/1").should route_to("branch_customers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/branch_customers/1").should route_to("branch_customers#destroy", :id => "1")
    end

  end
end
