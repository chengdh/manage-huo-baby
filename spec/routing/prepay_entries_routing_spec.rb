require "spec_helper"

describe PrepayEntriesController do
  describe "routing" do

    it "routes to #index" do
      get("/prepay_entries").should route_to("prepay_entries#index")
    end

    it "routes to #new" do
      get("/prepay_entries/new").should route_to("prepay_entries#new")
    end

    it "routes to #show" do
      get("/prepay_entries/1").should route_to("prepay_entries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/prepay_entries/1/edit").should route_to("prepay_entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/prepay_entries").should route_to("prepay_entries#create")
    end

    it "routes to #update" do
      put("/prepay_entries/1").should route_to("prepay_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/prepay_entries/1").should route_to("prepay_entries#destroy", :id => "1")
    end

  end
end
