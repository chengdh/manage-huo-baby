require 'spec_helper'

describe "DivideRptYujius" do
  describe "GET /divide_rpt_yujius" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get divide_rpt_yujius_path
      response.status.should be(200)
    end
  end
end
