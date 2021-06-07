require "spec_helper"

describe AutoCalculateComputerBillsController do
  describe "routing" do

    it "routes to #index" do
      get("/auto_calculate_computer_bills").should route_to("auto_calculate_computer_bills#index")
    end

    it "routes to #new" do
      get("/auto_calculate_computer_bills/new").should route_to("auto_calculate_computer_bills#new")
    end

    it "routes to #show" do
      get("/auto_calculate_computer_bills/1").should route_to("auto_calculate_computer_bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/auto_calculate_computer_bills/1/edit").should route_to("auto_calculate_computer_bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/auto_calculate_computer_bills").should route_to("auto_calculate_computer_bills#create")
    end

    it "routes to #update" do
      put("/auto_calculate_computer_bills/1").should route_to("auto_calculate_computer_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/auto_calculate_computer_bills/1").should route_to("auto_calculate_computer_bills#destroy", :id => "1")
    end

  end
end
