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

describe ScanHeaderLoadInsController do

  # This should return the minimal set of attributes required to create a valid
  # ScanHeaderLoadIn. As you add validations to ScanHeaderLoadIn, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ScanHeaderLoadInsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all scan_header_load_ins as @scan_header_load_ins" do
      scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
      get :index, {}, valid_session
      assigns(:scan_header_load_ins).should eq([scan_header_load_in])
    end
  end

  describe "GET show" do
    it "assigns the requested scan_header_load_in as @scan_header_load_in" do
      scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
      get :show, {:id => scan_header_load_in.to_param}, valid_session
      assigns(:scan_header_load_in).should eq(scan_header_load_in)
    end
  end

  describe "GET new" do
    it "assigns a new scan_header_load_in as @scan_header_load_in" do
      get :new, {}, valid_session
      assigns(:scan_header_load_in).should be_a_new(ScanHeaderLoadIn)
    end
  end

  describe "GET edit" do
    it "assigns the requested scan_header_load_in as @scan_header_load_in" do
      scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
      get :edit, {:id => scan_header_load_in.to_param}, valid_session
      assigns(:scan_header_load_in).should eq(scan_header_load_in)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ScanHeaderLoadIn" do
        expect {
          post :create, {:scan_header_load_in => valid_attributes}, valid_session
        }.to change(ScanHeaderLoadIn, :count).by(1)
      end

      it "assigns a newly created scan_header_load_in as @scan_header_load_in" do
        post :create, {:scan_header_load_in => valid_attributes}, valid_session
        assigns(:scan_header_load_in).should be_a(ScanHeaderLoadIn)
        assigns(:scan_header_load_in).should be_persisted
      end

      it "redirects to the created scan_header_load_in" do
        post :create, {:scan_header_load_in => valid_attributes}, valid_session
        response.should redirect_to(ScanHeaderLoadIn.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved scan_header_load_in as @scan_header_load_in" do
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderLoadIn.any_instance.stub(:save).and_return(false)
        post :create, {:scan_header_load_in => {}}, valid_session
        assigns(:scan_header_load_in).should be_a_new(ScanHeaderLoadIn)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderLoadIn.any_instance.stub(:save).and_return(false)
        post :create, {:scan_header_load_in => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested scan_header_load_in" do
        scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
        # Assuming there are no other scan_header_load_ins in the database, this
        # specifies that the ScanHeaderLoadIn created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ScanHeaderLoadIn.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => scan_header_load_in.to_param, :scan_header_load_in => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested scan_header_load_in as @scan_header_load_in" do
        scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
        put :update, {:id => scan_header_load_in.to_param, :scan_header_load_in => valid_attributes}, valid_session
        assigns(:scan_header_load_in).should eq(scan_header_load_in)
      end

      it "redirects to the scan_header_load_in" do
        scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
        put :update, {:id => scan_header_load_in.to_param, :scan_header_load_in => valid_attributes}, valid_session
        response.should redirect_to(scan_header_load_in)
      end
    end

    describe "with invalid params" do
      it "assigns the scan_header_load_in as @scan_header_load_in" do
        scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderLoadIn.any_instance.stub(:save).and_return(false)
        put :update, {:id => scan_header_load_in.to_param, :scan_header_load_in => {}}, valid_session
        assigns(:scan_header_load_in).should eq(scan_header_load_in)
      end

      it "re-renders the 'edit' template" do
        scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ScanHeaderLoadIn.any_instance.stub(:save).and_return(false)
        put :update, {:id => scan_header_load_in.to_param, :scan_header_load_in => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested scan_header_load_in" do
      scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
      expect {
        delete :destroy, {:id => scan_header_load_in.to_param}, valid_session
      }.to change(ScanHeaderLoadIn, :count).by(-1)
    end

    it "redirects to the scan_header_load_ins list" do
      scan_header_load_in = ScanHeaderLoadIn.create! valid_attributes
      delete :destroy, {:id => scan_header_load_in.to_param}, valid_session
      response.should redirect_to(scan_header_load_ins_url)
    end
  end

end
