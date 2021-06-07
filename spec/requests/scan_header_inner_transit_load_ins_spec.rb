require 'spec_helper'

describe "ScanHeaderInnerTransitLoadIns" do
  describe "GET /scan_header_inner_transit_load_ins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get scan_header_inner_transit_load_ins_path
      response.status.should be(200)
    end
  end
end
