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

describe TonVolumeBillsController do

  # This should return the minimal set of attributes required to create a valid
  # TonVolumeBill. As you add validations to TonVolumeBill, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TonVolumeBillsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all ton_volume_bills as @ton_volume_bills" do
      ton_volume_bill = TonVolumeBill.create! valid_attributes
      get :index, {}, valid_session
      assigns(:ton_volume_bills).should eq([ton_volume_bill])
    end
  end

  describe "GET show" do
    it "assigns the requested ton_volume_bill as @ton_volume_bill" do
      ton_volume_bill = TonVolumeBill.create! valid_attributes
      get :show, {:id => ton_volume_bill.to_param}, valid_session
      assigns(:ton_volume_bill).should eq(ton_volume_bill)
    end
  end

  describe "GET new" do
    it "assigns a new ton_volume_bill as @ton_volume_bill" do
      get :new, {}, valid_session
      assigns(:ton_volume_bill).should be_a_new(TonVolumeBill)
    end
  end

  describe "GET edit" do
    it "assigns the requested ton_volume_bill as @ton_volume_bill" do
      ton_volume_bill = TonVolumeBill.create! valid_attributes
      get :edit, {:id => ton_volume_bill.to_param}, valid_session
      assigns(:ton_volume_bill).should eq(ton_volume_bill)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TonVolumeBill" do
        expect {
          post :create, {:ton_volume_bill => valid_attributes}, valid_session
        }.to change(TonVolumeBill, :count).by(1)
      end

      it "assigns a newly created ton_volume_bill as @ton_volume_bill" do
        post :create, {:ton_volume_bill => valid_attributes}, valid_session
        assigns(:ton_volume_bill).should be_a(TonVolumeBill)
        assigns(:ton_volume_bill).should be_persisted
      end

      it "redirects to the created ton_volume_bill" do
        post :create, {:ton_volume_bill => valid_attributes}, valid_session
        response.should redirect_to(TonVolumeBill.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ton_volume_bill as @ton_volume_bill" do
        # Trigger the behavior that occurs when invalid params are submitted
        TonVolumeBill.any_instance.stub(:save).and_return(false)
        post :create, {:ton_volume_bill => {}}, valid_session
        assigns(:ton_volume_bill).should be_a_new(TonVolumeBill)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TonVolumeBill.any_instance.stub(:save).and_return(false)
        post :create, {:ton_volume_bill => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ton_volume_bill" do
        ton_volume_bill = TonVolumeBill.create! valid_attributes
        # Assuming there are no other ton_volume_bills in the database, this
        # specifies that the TonVolumeBill created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TonVolumeBill.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => ton_volume_bill.to_param, :ton_volume_bill => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested ton_volume_bill as @ton_volume_bill" do
        ton_volume_bill = TonVolumeBill.create! valid_attributes
        put :update, {:id => ton_volume_bill.to_param, :ton_volume_bill => valid_attributes}, valid_session
        assigns(:ton_volume_bill).should eq(ton_volume_bill)
      end

      it "redirects to the ton_volume_bill" do
        ton_volume_bill = TonVolumeBill.create! valid_attributes
        put :update, {:id => ton_volume_bill.to_param, :ton_volume_bill => valid_attributes}, valid_session
        response.should redirect_to(ton_volume_bill)
      end
    end

    describe "with invalid params" do
      it "assigns the ton_volume_bill as @ton_volume_bill" do
        ton_volume_bill = TonVolumeBill.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TonVolumeBill.any_instance.stub(:save).and_return(false)
        put :update, {:id => ton_volume_bill.to_param, :ton_volume_bill => {}}, valid_session
        assigns(:ton_volume_bill).should eq(ton_volume_bill)
      end

      it "re-renders the 'edit' template" do
        ton_volume_bill = TonVolumeBill.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TonVolumeBill.any_instance.stub(:save).and_return(false)
        put :update, {:id => ton_volume_bill.to_param, :ton_volume_bill => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ton_volume_bill" do
      ton_volume_bill = TonVolumeBill.create! valid_attributes
      expect {
        delete :destroy, {:id => ton_volume_bill.to_param}, valid_session
      }.to change(TonVolumeBill, :count).by(-1)
    end

    it "redirects to the ton_volume_bills list" do
      ton_volume_bill = TonVolumeBill.create! valid_attributes
      delete :destroy, {:id => ton_volume_bill.to_param}, valid_session
      response.should redirect_to(ton_volume_bills_url)
    end
  end

end