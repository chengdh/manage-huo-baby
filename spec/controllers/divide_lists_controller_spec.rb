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

describe DivideListsController do

  # This should return the minimal set of attributes required to create a valid
  # DivideList. As you add validations to DivideList, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DivideListsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all divide_lists as @divide_lists" do
      divide_list = DivideList.create! valid_attributes
      get :index, {}, valid_session
      assigns(:divide_lists).should eq([divide_list])
    end
  end

  describe "GET show" do
    it "assigns the requested divide_list as @divide_list" do
      divide_list = DivideList.create! valid_attributes
      get :show, {:id => divide_list.to_param}, valid_session
      assigns(:divide_list).should eq(divide_list)
    end
  end

  describe "GET new" do
    it "assigns a new divide_list as @divide_list" do
      get :new, {}, valid_session
      assigns(:divide_list).should be_a_new(DivideList)
    end
  end

  describe "GET edit" do
    it "assigns the requested divide_list as @divide_list" do
      divide_list = DivideList.create! valid_attributes
      get :edit, {:id => divide_list.to_param}, valid_session
      assigns(:divide_list).should eq(divide_list)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DivideList" do
        expect {
          post :create, {:divide_list => valid_attributes}, valid_session
        }.to change(DivideList, :count).by(1)
      end

      it "assigns a newly created divide_list as @divide_list" do
        post :create, {:divide_list => valid_attributes}, valid_session
        assigns(:divide_list).should be_a(DivideList)
        assigns(:divide_list).should be_persisted
      end

      it "redirects to the created divide_list" do
        post :create, {:divide_list => valid_attributes}, valid_session
        response.should redirect_to(DivideList.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved divide_list as @divide_list" do
        # Trigger the behavior that occurs when invalid params are submitted
        DivideList.any_instance.stub(:save).and_return(false)
        post :create, {:divide_list => {}}, valid_session
        assigns(:divide_list).should be_a_new(DivideList)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DivideList.any_instance.stub(:save).and_return(false)
        post :create, {:divide_list => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested divide_list" do
        divide_list = DivideList.create! valid_attributes
        # Assuming there are no other divide_lists in the database, this
        # specifies that the DivideList created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DivideList.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => divide_list.to_param, :divide_list => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested divide_list as @divide_list" do
        divide_list = DivideList.create! valid_attributes
        put :update, {:id => divide_list.to_param, :divide_list => valid_attributes}, valid_session
        assigns(:divide_list).should eq(divide_list)
      end

      it "redirects to the divide_list" do
        divide_list = DivideList.create! valid_attributes
        put :update, {:id => divide_list.to_param, :divide_list => valid_attributes}, valid_session
        response.should redirect_to(divide_list)
      end
    end

    describe "with invalid params" do
      it "assigns the divide_list as @divide_list" do
        divide_list = DivideList.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DivideList.any_instance.stub(:save).and_return(false)
        put :update, {:id => divide_list.to_param, :divide_list => {}}, valid_session
        assigns(:divide_list).should eq(divide_list)
      end

      it "re-renders the 'edit' template" do
        divide_list = DivideList.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DivideList.any_instance.stub(:save).and_return(false)
        put :update, {:id => divide_list.to_param, :divide_list => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested divide_list" do
      divide_list = DivideList.create! valid_attributes
      expect {
        delete :destroy, {:id => divide_list.to_param}, valid_session
      }.to change(DivideList, :count).by(-1)
    end

    it "redirects to the divide_lists list" do
      divide_list = DivideList.create! valid_attributes
      delete :destroy, {:id => divide_list.to_param}, valid_session
      response.should redirect_to(divide_lists_url)
    end
  end

end
