require 'spec_helper'

describe "local_town_return_bills/index" do
  before(:each) do
    assign(:local_town_return_bills, [
      stub_model(LocalTownReturnBill),
      stub_model(LocalTownReturnBill)
    ])
  end

  it "renders a list of local_town_return_bills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
