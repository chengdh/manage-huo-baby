require "spec_helper"

describe OrgSortingsController do
  describe "routing" do

    it "routes to #index" do
      get("/org_sortings").should route_to("org_sortings#index")
    end

    it "routes to #new" do
      get("/org_sortings/new").should route_to("org_sortings#new")
    end

    it "routes to #show" do
      get("/org_sortings/1").should route_to("org_sortings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/org_sortings/1/edit").should route_to("org_sortings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/org_sortings").should route_to("org_sortings#create")
    end

    it "routes to #update" do
      put("/org_sortings/1").should route_to("org_sortings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/org_sortings/1").should route_to("org_sortings#destroy", :id => "1")
    end

  end
end
