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

describe ScanHeaderSubBranchesController do

  # This should return the minimal set of attributes required to create a valid
  # ScanHeaderSubBranch. As you add validations to ScanHeaderSubBranch, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ScanHeaderSubBranchesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all scan_header_sub_branches as @scan_header_sub_branches" do
      scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
      get :index, {}, valid_session
      assigns(:scan_header_sub_branches).should eq([scan_header_sub_branch])
    end
  end

  describe "GET show" do
    it "assigns the requested scan_header_sub_branch as @scan_header_sub_branch" do
      scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
      get :show, {:id => scan_header_sub_branch.to_param}, valid_session
      assigns(:scan_header_sub_branch).should eq(scan_header_sub_branch)
    end
  end

  describe "GET new" do
    it "assigns a new scan_header_sub_branch as @scan_header_sub_branch" do
      get :new, {}, valid_session
      assigns(:scan_header_sub_branch).should be_a_new(ScanHeaderSubBranch)
    end
  end

  describe "GET edit" do
    it "assigns the requested scan_header_sub_branch as @scan_header_sub_branch" do
      scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
      get :edit, {:id => scan_header_sub_branch.to_param}, valid_session
      assigns(:scan_header_sub_branch).should eq(scan_header_sub_branch)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ScanHeaderSubBranch" do
        expect {
          post :create, {:scan_header_sub_branch => valid_attributes}, valid_session
        }.to change(ScanHeaderSubBranch, :count).by(1)
      end

      it "assigns a newly created scan_header_sub_branch as @scan_header_sub_branch" do
        post :create, {:scan_header_sub_branch => valid_attributes}, valid_session
        assigns(:scan_header_sub_branch).should be_a(ScanHeaderSubBranch)
        assigns(:scan_header_sub_branch).should be_persisted
      end

      it "redirects to the created scan_header_sub_branch" do
        post :create, {:scan_header_sub_branch => valid_attributes}, valid_session
        response.should redirect_to(ScanHeaderSubBranch.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved scan_header_sub_branch as @scan_header_sub_branch" do
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderSubBranch.any_instance.stub(:save).and_return(false)
        post :create, {:scan_header_sub_branch => {}}, valid_session
        assigns(:scan_header_sub_branch).should be_a_new(ScanHeaderSubBranch)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderSubBranch.any_instance.stub(:save).and_return(false)
        post :create, {:scan_header_sub_branch => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested scan_header_sub_branch" do
        scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
        # Assuming there are no other scan_header_sub_branches in the database, this
        # specifies that the ScanHeaderSubBranch created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ScanHeaderSubBranch.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => scan_header_sub_branch.to_param, :scan_header_sub_branch => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested scan_header_sub_branch as @scan_header_sub_branch" do
        scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
        put :update, {:id => scan_header_sub_branch.to_param, :scan_header_sub_branch => valid_attributes}, valid_session
        assigns(:scan_header_sub_branch).should eq(scan_header_sub_branch)
      end

      it "redirects to the scan_header_sub_branch" do
        scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
        put :update, {:id => scan_header_sub_branch.to_param, :scan_header_sub_branch => valid_attributes}, valid_session
        response.should redirect_to(scan_header_sub_branch)
      end
    end

    describe "with invalid params" do
      it "assigns the scan_header_sub_branch as @scan_header_sub_branch" do
        scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderSubBranch.any_instance.stub(:save).and_return(false)
        put :update, {:id => scan_header_sub_branch.to_param, :scan_header_sub_branch => {}}, valid_session
        assigns(:scan_header_sub_branch).should eq(scan_header_sub_branch)
      end

      it "re-renders the 'edit' template" do
        scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderSubBranch.any_instance.stub(:save).and_return(false)
        put :update, {:id => scan_header_sub_branch.to_param, :scan_header_sub_branch => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested scan_header_sub_branch" do
      scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
      expect {
        delete :destroy, {:id => scan_header_sub_branch.to_param}, valid_session
      }.to change(ScanHeaderSubBranch, :count).by(-1)
    end

    it "redirects to the scan_header_sub_branches list" do
      scan_header_sub_branch = ScanHeaderSubBranch.create! valid_attributes
      delete :destroy, {:id => scan_header_sub_branch.to_param}, valid_session
      response.should redirect_to(scan_header_sub_branches_url)
    end
  end

end
