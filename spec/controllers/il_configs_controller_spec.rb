# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe IlConfigsController do
  login_admin
  render_views


  describe "GET index" do
    it "assigns all il_configs as @il_configs" do
      @il_config = Factory(:il_config)
      get :index
      response.should be_success
    end
  end

  describe "GET show" do

    it "should be success" do

      @il_config = Factory(:il_config)
      get :show, :id => @il_config
      response.should be_success
    end

    it "assigns the requested il_config as @il_config" do

      @il_config = Factory(:il_config)
      get :show, :id => @il_config
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
    it "assigns the requested il_config as @il_config" do
      @il_config = Factory(:il_config)
      get :edit, :id => @il_config
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:il_config).attributes
    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :il_config => @attr
        end.should change(IlConfig,:count).by(1)
      end

      it "redirects to the created il_config" do
        post :create, :il_config => @attr
        response.should redirect_to(il_config_path(assigns(:il_config)))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :il_config => {:key => nil}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @il_config = Factory(:il_config)
      @attr = {:title => 'changed_title'}
    end

    describe "with valid params" do
      it "updates the requested il_config" do
        put :update, :id => @il_config, :il_config => @attr 
        @il_config.reload
        @il_config.title.should == @attr[:title]
      end


      it "redirects to the il_config" do
        put :update, :id => @il_config,:il_config => @attr
        response.should redirect_to(il_config_path(@il_config))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @il_config,:il_config => {:key => nil}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    before :each do
      @il_config = Factory(:il_config)
    end
    it "destroys the requested il_config" do
      lambda do
        delete :destroy, :id => @il_config 
      end.should change(IlConfig,:count).by(-1)
    end

    it "redirects to the il_configs list" do

      delete :destroy, :id => @il_config 
      response.should redirect_to(il_configs_url)
    end
  end
end

