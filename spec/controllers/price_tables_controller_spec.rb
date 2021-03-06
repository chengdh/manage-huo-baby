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

describe PriceTablesController do

  # This should return the minimal set of attributes required to create a valid
  # PriceTable. As you add validations to PriceTable, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PriceTablesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all price_tables as @price_tables" do
      price_table = PriceTable.create! valid_attributes
      get :index, {}, valid_session
      assigns(:price_tables).should eq([price_table])
    end
  end

  describe "GET show" do
    it "assigns the requested price_table as @price_table" do
      price_table = PriceTable.create! valid_attributes
      get :show, {:id => price_table.to_param}, valid_session
      assigns(:price_table).should eq(price_table)
    end
  end

  describe "GET new" do
    it "assigns a new price_table as @price_table" do
      get :new, {}, valid_session
      assigns(:price_table).should be_a_new(PriceTable)
    end
  end

  describe "GET edit" do
    it "assigns the requested price_table as @price_table" do
      price_table = PriceTable.create! valid_attributes
      get :edit, {:id => price_table.to_param}, valid_session
      assigns(:price_table).should eq(price_table)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new PriceTable" do
        expect {
          post :create, {:price_table => valid_attributes}, valid_session
        }.to change(PriceTable, :count).by(1)
      end

      it "assigns a newly created price_table as @price_table" do
        post :create, {:price_table => valid_attributes}, valid_session
        assigns(:price_table).should be_a(PriceTable)
        assigns(:price_table).should be_persisted
      end

      it "redirects to the created price_table" do
        post :create, {:price_table => valid_attributes}, valid_session
        response.should redirect_to(PriceTable.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved price_table as @price_table" do
        # Trigger the behavior that occurs when invalid params are submitted
        PriceTable.any_instance.stub(:save).and_return(false)
        post :create, {:price_table => {}}, valid_session
        assigns(:price_table).should be_a_new(PriceTable)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PriceTable.any_instance.stub(:save).and_return(false)
        post :create, {:price_table => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested price_table" do
        price_table = PriceTable.create! valid_attributes
        # Assuming there are no other price_tables in the database, this
        # specifies that the PriceTable created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        PriceTable.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => price_table.to_param, :price_table => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested price_table as @price_table" do
        price_table = PriceTable.create! valid_attributes
        put :update, {:id => price_table.to_param, :price_table => valid_attributes}, valid_session
        assigns(:price_table).should eq(price_table)
      end

      it "redirects to the price_table" do
        price_table = PriceTable.create! valid_attributes
        put :update, {:id => price_table.to_param, :price_table => valid_attributes}, valid_session
        response.should redirect_to(price_table)
      end
    end

    describe "with invalid params" do
      it "assigns the price_table as @price_table" do
        price_table = PriceTable.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PriceTable.any_instance.stub(:save).and_return(false)
        put :update, {:id => price_table.to_param, :price_table => {}}, valid_session
        assigns(:price_table).should eq(price_table)
      end

      it "re-renders the 'edit' template" do
        price_table = PriceTable.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PriceTable.any_instance.stub(:save).and_return(false)
        put :update, {:id => price_table.to_param, :price_table => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested price_table" do
      price_table = PriceTable.create! valid_attributes
      expect {
        delete :destroy, {:id => price_table.to_param}, valid_session
      }.to change(PriceTable, :count).by(-1)
    end

    it "redirects to the price_tables list" do
      price_table = PriceTable.create! valid_attributes
      delete :destroy, {:id => price_table.to_param}, valid_session
      response.should redirect_to(price_tables_url)
    end
  end

end
