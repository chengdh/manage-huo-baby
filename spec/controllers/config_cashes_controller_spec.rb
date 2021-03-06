# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe ConfigCashesController do
  login_admin
  render_views

  before(:each) do
    @config_cash = Factory(:config_cash)
  end


  describe "GET index" do
    it "assigns all config_cashs as @config_cashs" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do

    it "should be success" do
      get :show, :id => @config_cash
      response.should be_success
    end

    it "assigns the requested config_cash as @config_cash" do
      get :show, :id => @config_cash
      response.should render_template('show')
    end
  end

  describe "GET new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end

  describe "GET edit" do
    it "assigns the requested config_cash as @config_cash" do
      get :edit, :id => @config_cash
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:config_cash).attributes
    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :config_cash => @attr
        end.should change(ConfigCash,:count).by(1)
      end

      it "redirects to the created config_cash" do
        post :create, :config_cash => @attr
        response.should redirect_to(config_cash_path(assigns(:config_cash)))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :config_cash => {:fee_from => nil,:fee_to => nil,:hand_fee => nil}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @attr = {:hand_fee => 2.9}
    end

    describe "with valid params" do
      it "updates the requested config_cash" do
        put :update, :id => @config_cash, :config_cash => @attr 
        @config_cash.reload
        @config_cash.hand_fee.should == 2.9
      end


      it "redirects to the config_cash" do
        put :update, :id => @config_cash,:config_cash => @attr
        response.should redirect_to(config_cash_path(@config_cash))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @config_cash,:config_cash => {:fee_from => nil,:fee_to => nil,:hand_fee => nil}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested config_cash" do
      lambda do
        delete :destroy, :id => @config_cash 
      end.should change(ConfigCash,:count).by(-1)
    end

    it "redirects to the config_cashs list" do
      delete :destroy, :id => @config_cash 
      response.should redirect_to(config_cashes_url)
    end
  end
end

