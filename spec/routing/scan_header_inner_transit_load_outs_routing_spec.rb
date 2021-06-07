require "spec_helper"

describe ScanHeaderInnerTransitLoadOutsController do
  describe "routing" do

    it "routes to #index" do
      get("/scan_header_inner_transit_load_outs").should route_to("scan_header_inner_transit_load_outs#index")
    end

    it "routes to #new" do
      get("/scan_header_inner_transit_load_outs/new").should route_to("scan_header_inner_transit_load_outs#new")
    end

    it "routes to #show" do
      get("/scan_header_inner_transit_load_outs/1").should route_to("scan_header_inner_transit_load_outs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/scan_header_inner_transit_load_outs/1/edit").should route_to("scan_header_inner_transit_load_outs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/scan_header_inner_transit_load_outs").should route_to("scan_header_inner_transit_load_outs#create")
    end

    it "routes to #update" do
      put("/scan_header_inner_transit_load_outs/1").should route_to("scan_header_inner_transit_load_outs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/scan_header_inner_transit_load_outs/1").should route_to("scan_header_inner_transit_load_outs#destroy", :id => "1")
    end

  end
end
