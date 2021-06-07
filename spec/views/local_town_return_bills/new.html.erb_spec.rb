require 'spec_helper'

describe "local_town_return_bills/new" do
  before(:each) do
    assign(:local_town_return_bill, stub_model(LocalTownReturnBill).as_new_record)
  end

  it "renders new local_town_return_bill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => local_town_return_bills_path, :method => "post" do
    end
  end
end
