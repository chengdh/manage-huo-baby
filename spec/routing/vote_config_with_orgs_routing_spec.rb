require "spec_helper"

describe VoteConfigWithOrgsController do
  describe "routing" do

    it "routes to #index" do
      get("/vote_config_with_orgs").should route_to("vote_config_with_orgs#index")
    end

    it "routes to #new" do
      get("/vote_config_with_orgs/new").should route_to("vote_config_with_orgs#new")
    end

    it "routes to #show" do
      get("/vote_config_with_orgs/1").should route_to("vote_config_with_orgs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vote_config_with_orgs/1/edit").should route_to("vote_config_with_orgs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vote_config_with_orgs").should route_to("vote_config_with_orgs#create")
    end

    it "routes to #update" do
      put("/vote_config_with_orgs/1").should route_to("vote_config_with_orgs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vote_config_with_orgs/1").should route_to("vote_config_with_orgs#destroy", :id => "1")
    end

  end
end
