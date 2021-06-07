require 'spec_helper'

describe "local_town_return_bills/edit" do
  before(:each) do
    @local_town_return_bill = assign(:local_town_return_bill, stub_model(LocalTownReturnBill))
  end

  it "renders the edit local_town_return_bill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => local_town_return_bills_path(@local_town_return_bill), :method => "post" do
    end
  end
end
