require "spec_helper"

describe SingleVoteConfigWithOrgsController do
  describe "routing" do

    it "routes to #index" do
      get("/single_vote_config_with_orgs").should route_to("single_vote_config_with_orgs#index")
    end

    it "routes to #new" do
      get("/single_vote_config_with_orgs/new").should route_to("single_vote_config_with_orgs#new")
    end

    it "routes to #show" do
      get("/single_vote_config_with_orgs/1").should route_to("single_vote_config_with_orgs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/single_vote_config_with_orgs/1/edit").should route_to("single_vote_config_with_orgs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/single_vote_config_with_orgs").should route_to("single_vote_config_with_orgs#create")
    end

    it "routes to #update" do
      put("/single_vote_config_with_orgs/1").should route_to("single_vote_config_with_orgs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/single_vote_config_with_orgs/1").should route_to("single_vote_config_with_orgs#destroy", :id => "1")
    end

  end
end
