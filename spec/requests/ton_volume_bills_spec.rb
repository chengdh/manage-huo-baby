require 'spec_helper'

describe "TonVolumeBills" do
  describe "GET /ton_volume_bills" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get ton_volume_bills_path
      response.status.should be(200)
    end
  end
end
