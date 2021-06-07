#coding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BranchInventoriesController do
  login_admin
  render_views

  describe "GET index" do
    before(:each) do
      @branch_inventories ||= [Factory(:branch_inventory)]
    end

    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET before_new" do
    it "should be success" do
      get :before_new
      response.should be_success
    end
  end

  describe "GET show" do
    before(:each) do
      @branch_inventory ||= Factory(:branch_inventory)
    end

    it "should render 'show'" do
      get :show, :id => @branch_inventory
      response.should render_template('show')
    end
  end

  describe "GET new with no search params" do
    it "should be redirect to before_new" do
      get :new
      response.should redirect_to :action => :before_new
    end
  end

  describe "GET search" do
    it "should render search" do
      get :search
      response.should render_template("_search")
    end
  end

  describe "GET export_excel" do
    it "should success" do
      @branch_inventory = Factory(:branch_inventory)
      get :export_excel,:id => @branch_inventory
      response.should be_success
    end
  end

  describe "GET new with search params" do
    it "should be success" do
      get :new,:search => {:from_org_id_eq => Factory(:zz)}
      response.should be_success
    end
    it "should render 'new' template" do
      get :new,:search => {:from_org_id_eq => Factory(:zz)}
      response.should render_template('new')
    end
  end

  describe "POST create" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end
    describe "with valid params" do
      it "the branch_inventory should success create" do
        lambda do
          post :create,:branch_inventory => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)}
        end.should change(BranchInventory,:count).by(1)
      end

      it "redirects to the created load_list" do
        post :create,:branch_inventory => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)}
        response.should redirect_to(assigns[:branch_inventory])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :branch_inventory => {:bill_no => "bill_no"}
        response.should render_template('new')
      end
    end
  end


  describe "DELETE destroy" do
    before(:each) do
      @branch_inventory ||= Factory(:branch_inventory)
    end

    it "destroys the requested branch_inventory" do
      lambda do
        delete :destroy ,:id => @branch_inventory
      end.should change(BranchInventory,:count).by(-1)
    end

    it "redirects to the branch inventory list" do
      delete :destroy, :id => @branch_inventory
      response.should redirect_to(branch_inventories_url)
    end
  end
end