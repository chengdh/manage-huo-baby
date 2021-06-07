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

describe AdjustGoodsFeeInfosController do

  # This should return the minimal set of attributes required to create a valid
  # AdjustGoodsFeeInfo. As you add validations to AdjustGoodsFeeInfo, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdjustGoodsFeeInfosController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all adjust_goods_fee_infos as @adjust_goods_fee_infos" do
      adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
      get :index, {}, valid_session
      assigns(:adjust_goods_fee_infos).should eq([adjust_goods_fee_info])
    end
  end

  describe "GET show" do
    it "assigns the requested adjust_goods_fee_info as @adjust_goods_fee_info" do
      adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
      get :show, {:id => adjust_goods_fee_info.to_param}, valid_session
      assigns(:adjust_goods_fee_info).should eq(adjust_goods_fee_info)
    end
  end

  describe "GET new" do
    it "assigns a new adjust_goods_fee_info as @adjust_goods_fee_info" do
      get :new, {}, valid_session
      assigns(:adjust_goods_fee_info).should be_a_new(AdjustGoodsFeeInfo)
    end
  end

  describe "GET edit" do
    it "assigns the requested adjust_goods_fee_info as @adjust_goods_fee_info" do
      adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
      get :edit, {:id => adjust_goods_fee_info.to_param}, valid_session
      assigns(:adjust_goods_fee_info).should eq(adjust_goods_fee_info)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AdjustGoodsFeeInfo" do
        expect {
          post :create, {:adjust_goods_fee_info => valid_attributes}, valid_session
        }.to change(AdjustGoodsFeeInfo, :count).by(1)
      end

      it "assigns a newly created adjust_goods_fee_info as @adjust_goods_fee_info" do
        post :create, {:adjust_goods_fee_info => valid_attributes}, valid_session
        assigns(:adjust_goods_fee_info).should be_a(AdjustGoodsFeeInfo)
        assigns(:adjust_goods_fee_info).should be_persisted
      end

      it "redirects to the created adjust_goods_fee_info" do
        post :create, {:adjust_goods_fee_info => valid_attributes}, valid_session
        response.should redirect_to(AdjustGoodsFeeInfo.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved adjust_goods_fee_info as @adjust_goods_fee_info" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdjustGoodsFeeInfo.any_instance.stub(:save).and_return(false)
        post :create, {:adjust_goods_fee_info => {}}, valid_session
        assigns(:adjust_goods_fee_info).should be_a_new(AdjustGoodsFeeInfo)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdjustGoodsFeeInfo.any_instance.stub(:save).and_return(false)
        post :create, {:adjust_goods_fee_info => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested adjust_goods_fee_info" do
        adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
        # Assuming there are no other adjust_goods_fee_infos in the database, this
        # specifies that the AdjustGoodsFeeInfo created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AdjustGoodsFeeInfo.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => adjust_goods_fee_info.to_param, :adjust_goods_fee_info => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested adjust_goods_fee_info as @adjust_goods_fee_info" do
        adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
        put :update, {:id => adjust_goods_fee_info.to_param, :adjust_goods_fee_info => valid_attributes}, valid_session
        assigns(:adjust_goods_fee_info).should eq(adjust_goods_fee_info)
      end

      it "redirects to the adjust_goods_fee_info" do
        adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
        put :update, {:id => adjust_goods_fee_info.to_param, :adjust_goods_fee_info => valid_attributes}, valid_session
        response.should redirect_to(adjust_goods_fee_info)
      end
    end

    describe "with invalid params" do
      it "assigns the adjust_goods_fee_info as @adjust_goods_fee_info" do
        adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AdjustGoodsFeeInfo.any_instance.stub(:save).and_return(false)
        put :update, {:id => adjust_goods_fee_info.to_param, :adjust_goods_fee_info => {}}, valid_session
        assigns(:adjust_goods_fee_info).should eq(adjust_goods_fee_info)
      end

      it "re-renders the 'edit' template" do
        adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AdjustGoodsFeeInfo.any_instance.stub(:save).and_return(false)
        put :update, {:id => adjust_goods_fee_info.to_param, :adjust_goods_fee_info => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested adjust_goods_fee_info" do
      adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
      expect {
        delete :destroy, {:id => adjust_goods_fee_info.to_param}, valid_session
      }.to change(AdjustGoodsFeeInfo, :count).by(-1)
    end

    it "redirects to the adjust_goods_fee_infos list" do
      adjust_goods_fee_info = AdjustGoodsFeeInfo.create! valid_attributes
      delete :destroy, {:id => adjust_goods_fee_info.to_param}, valid_session
      response.should redirect_to(adjust_goods_fee_infos_url)
    end
  end

end