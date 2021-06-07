require 'spec_helper'

describe "LocalTownReturnBills" do
  describe "GET /local_town_return_bills" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get local_town_return_bills_path
      response.status.should be(200)
    end
  end
end
