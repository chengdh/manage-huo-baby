require 'spec_helper'

describe "CustomerPaymentInfos" do
  describe "GET /customer_payment_infos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get customer_payment_infos_path
      response.status.should be(200)
    end
  end
end
