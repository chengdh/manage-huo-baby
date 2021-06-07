require 'spec_helper'

describe "local_town_return_bills/show" do
  before(:each) do
    @local_town_return_bill = assign(:local_town_return_bill, stub_model(LocalTownReturnBill))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
