require "spec_helper"

describe RegionsController do
  describe "routing" do

    it "routes to #index" do
      get("/regions").should route_to("regions#index")
    end

    it "routes to #new" do
      get("/regions/new").should route_to("regions#new")
    end

    it "routes to #show" do
      get("/regions/1").should route_to("regions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/regions/1/edit").should route_to("regions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/regions").should route_to("regions#create")
    end

    it "routes to #update" do
      put("/regions/1").should route_to("regions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/regions/1").should route_to("regions#destroy", :id => "1")
    end

  end
end
