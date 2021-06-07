# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe RolesController do
  login_admin
  render_views

  before(:each) do
    @role = Factory(:common_role)
  end


  describe "GET index" do
    it "assigns all roles as @roles" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do

    it "should be success" do
      get :show, :id => @role
      response.should be_success
    end

    it "assigns the requested role as @role" do
      get :show, :id => @role
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
    it "assigns the requested role as @role" do
      get :edit, :id => @role
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = {:name => 'test_role'}
    end
    describe "success" do
      it "能够成功保存角色信息" do
        lambda do
          post :create, :role => @attr
        end.should change(Role,:count).by(1)
      end

      it "redirects to the created role" do
        post :create, :role => @attr
        response.should redirect_to(role_path(assigns(:role)))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :role => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @attr = {:name => 'updated name'}
    end

    describe "with valid params" do
      it "updates the requested role" do
        put :update, :id => @role, :role => {:is_active => false} 
        @role.reload
        @role.should_not be_is_active
      end


      it "redirects to the role" do
        put :update, :id => @role,:role => @attr
        response.should redirect_to(role_path(assigns(:role)))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @role,:role => {:name => nil}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested role" do
      lambda do
        delete :destroy, :id => @role 
      end.should change(Role,:count).by(-1)
    end

    it "redirects to the roles list" do
      delete :destroy, :id => @role 
      response.should redirect_to(roles_url)
    end
  end
end

