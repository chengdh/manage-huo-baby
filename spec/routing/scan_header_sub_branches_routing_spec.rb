require "spec_helper"

describe ScanHeaderSubBranchesController do
  describe "routing" do

    it "routes to #index" do
      get("/scan_header_sub_branches").should route_to("scan_header_sub_branches#index")
    end

    it "routes to #new" do
      get("/scan_header_sub_branches/new").should route_to("scan_header_sub_branches#new")
    end

    it "routes to #show" do
      get("/scan_header_sub_branches/1").should route_to("scan_header_sub_branches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/scan_header_sub_branches/1/edit").should route_to("scan_header_sub_branches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/scan_header_sub_branches").should route_to("scan_header_sub_branches#create")
    end

    it "routes to #update" do
      put("/scan_header_sub_branches/1").should route_to("scan_header_sub_branches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/scan_header_sub_branches/1").should route_to("scan_header_sub_branches#destroy", :id => "1")
    end

  end
end
