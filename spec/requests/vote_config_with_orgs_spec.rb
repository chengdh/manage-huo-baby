require 'spec_helper'

describe "VoteConfigWithOrgs" do
  describe "GET /vote_config_with_orgs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get vote_config_with_orgs_path
      response.status.should be(200)
    end
  end
end
