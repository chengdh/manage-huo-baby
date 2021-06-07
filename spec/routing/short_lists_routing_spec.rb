require "spec_helper"

describe ShortListsController do
  describe "routing" do

    it "routes to #index" do
      get("/short_lists").should route_to("short_lists#index")
    end

    it "routes to #new" do
      get("/short_lists/new").should route_to("short_lists#new")
    end

    it "routes to #show" do
      get("/short_lists/1").should route_to("short_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/short_lists/1/edit").should route_to("short_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/short_lists").should route_to("short_lists#create")
    end

    it "routes to #update" do
      put("/short_lists/1").should route_to("short_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/short_lists/1").should route_to("short_lists#destroy", :id => "1")
    end

  end
end
