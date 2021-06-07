require "spec_helper"

describe DebtBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/debt_bills").should route_to("debt_bills#index")
    end

    it "routes to #new" do
      get("/debt_bills/new").should route_to("debt_bills#new")
    end

    it "routes to #show" do
      get("/debt_bills/1").should route_to("debt_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/debt_bills/1/edit").should route_to("debt_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/debt_bills").should route_to("debt_bills#create")
    end

    it "routes to #update" do
      put("/debt_bills/1").should route_to("debt_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/debt_bills/1").should route_to("debt_bills#destroy", :id => "1")
    end

  end
end
