require "spec_helper"

describe LoadListWithBarcodesController do
  describe "routing" do

    it "routes to #index" do
      get("/load_list_with_barcodes").should route_to("load_list_with_barcodes#index")
    end

    it "routes to #new" do
      get("/load_list_with_barcodes/new").should route_to("load_list_with_barcodes#new")
    end

    it "routes to #show" do
      get("/load_list_with_barcodes/1").should route_to("load_list_with_barcodes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/load_list_with_barcodes/1/edit").should route_to("load_list_with_barcodes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/load_list_with_barcodes").should route_to("load_list_with_barcodes#create")
    end

    it "routes to #update" do
      put("/load_list_with_barcodes/1").should route_to("load_list_with_barcodes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/load_list_with_barcodes/1").should route_to("load_list_with_barcodes#destroy", :id => "1")
    end

  end
end
