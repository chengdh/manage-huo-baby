require "spec_helper"

describe ScanHeadersController do
  describe "routing" do

    it "routes to #index" do
      get("/scan_headers").should route_to("scan_headers#index")
    end

    it "routes to #new" do
      get("/scan_headers/new").should route_to("scan_headers#new")
    end

    it "routes to #show" do
      get("/scan_headers/1").should route_to("scan_headers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/scan_headers/1/edit").should route_to("scan_headers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/scan_headers").should route_to("scan_headers#create")
    end

    it "routes to #update" do
      put("/scan_headers/1").should route_to("scan_headers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/scan_headers/1").should route_to("scan_headers#destroy", :id => "1")
    end

  end
end
