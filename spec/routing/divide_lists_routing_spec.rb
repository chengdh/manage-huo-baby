require "spec_helper"

describe DivideListsController do
  describe "routing" do

    it "routes to #index" do
      get("/divide_lists").should route_to("divide_lists#index")
    end

    it "routes to #new" do
      get("/divide_lists/new").should route_to("divide_lists#new")
    end

    it "routes to #show" do
      get("/divide_lists/1").should route_to("divide_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/divide_lists/1/edit").should route_to("divide_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/divide_lists").should route_to("divide_lists#create")
    end

    it "routes to #update" do
      put("/divide_lists/1").should route_to("divide_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/divide_lists/1").should route_to("divide_lists#destroy", :id => "1")
    end

  end
end
