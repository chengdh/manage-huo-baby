require "spec_helper"

describe ScanHeaderSortingInsController do
  describe "routing" do

    it "routes to #index" do
      get("/scan_header_sorting_ins").should route_to("scan_header_sorting_ins#index")
    end

    it "routes to #new" do
      get("/scan_header_sorting_ins/new").should route_to("scan_header_sorting_ins#new")
    end

    it "routes to #show" do
      get("/scan_header_sorting_ins/1").should route_to("scan_header_sorting_ins#show", :id => "1")
    end

    it "routes to #edit" do
      get("/scan_header_sorting_ins/1/edit").should route_to("scan_header_sorting_ins#edit", :id => "1")
    end

    it "routes to #create" do
      post("/scan_header_sorting_ins").should route_to("scan_header_sorting_ins#create")
    end

    it "routes to #update" do
      put("/scan_header_sorting_ins/1").should route_to("scan_header_sorting_ins#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/scan_header_sorting_ins/1").should route_to("scan_header_sorting_ins#destroy", :id => "1")
    end

  end
end
