require 'spec_helper'

describe "DeliverRegions" do
  describe "GET /deliver_regions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get deliver_regions_path
      response.status.should be(302)
    end
  end
end
