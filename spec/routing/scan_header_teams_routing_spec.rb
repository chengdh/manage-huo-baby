require "spec_helper"

describe ScanHeaderTeamsController do
  describe "routing" do

    it "routes to #index" do
      get("/scan_header_teams").should route_to("scan_header_teams#index")
    end

    it "routes to #new" do
      get("/scan_header_teams/new").should route_to("scan_header_teams#new")
    end

    it "routes to #show" do
      get("/scan_header_teams/1").should route_to("scan_header_teams#show", :id => "1")
    end

    it "routes to #edit" do
      get("/scan_header_teams/1/edit").should route_to("scan_header_teams#edit", :id => "1")
    end

    it "routes to #create" do
      post("/scan_header_teams").should route_to("scan_header_teams#create")
    end

    it "routes to #update" do
      put("/scan_header_teams/1").should route_to("scan_header_teams#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/scan_header_teams/1").should route_to("scan_header_teams#destroy", :id => "1")
    end

  end
end
