require "spec_helper"

describe OrgLoadsController do
  describe "routing" do

    it "routes to #index" do
      get("/org_loads").should route_to("org_loads#index")
    end

    it "routes to #new" do
      get("/org_loads/new").should route_to("org_loads#new")
    end

    it "routes to #show" do
      get("/org_loads/1").should route_to("org_loads#show", :id => "1")
    end

    it "routes to #edit" do
      get("/org_loads/1/edit").should route_to("org_loads#edit", :id => "1")
    end

    it "routes to #create" do
      post("/org_loads").should route_to("org_loads#create")
    end

    it "routes to #update" do
      put("/org_loads/1").should route_to("org_loads#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/org_loads/1").should route_to("org_loads#destroy", :id => "1")
    end

  end
end
