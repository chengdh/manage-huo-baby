require 'spec_helper'
describe LoadListWithBarcodesController do
  login_admin
  render_views
  describe "GET index" do
    before(:each) do
      @load_list_with_barcode ||= Factory(:load_list_with_barcode)
    end

    it "should be success" do
      get :index
      response.should be_success
    end
    it "should be success with xml request" do
      get :index,:format => :xml
      response.should be_success
    end
  end
  describe "POST create" do
    it "the load_list should success create with nested attributes" do
      lambda do
        post :create,:format => :xml,:load_list_with_barcode => {:from_org_id =>Factory(:zz),:to_org_id => Factory(:ay),:bill_no => "bill_no","load_list_with_barcode_lines_attributes" => {"0" => {"barcode" => "00140000003003002"},"1" => {"barcode" => "00140000003003004"}}}
      end.should change(LoadListWithBarcode,:count).by(1)
    end
  end
end
