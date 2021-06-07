require "spec_helper"

describe VoteConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/vote_configs").should route_to("vote_configs#index")
    end

    it "routes to #new" do
      get("/vote_configs/new").should route_to("vote_configs#new")
    end

    it "routes to #show" do
      get("/vote_configs/1").should route_to("vote_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vote_configs/1/edit").should route_to("vote_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vote_configs").should route_to("vote_configs#create")
    end

    it "routes to #update" do
      put("/vote_configs/1").should route_to("vote_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vote_configs/1").should route_to("vote_configs#destroy", :id => "1")
    end

  end
end
