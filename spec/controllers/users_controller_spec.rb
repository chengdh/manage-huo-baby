# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe UsersController do
  login_admin
  render_views
  before :each do
    @user = Factory(:test_user)
  end


  describe "GET index" do
    it "assigns all users as @users" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do

    it "should be success" do
      get :show, :id => @user
      response.should be_success
    end

    it "assigns the requested user as @user" do
      get :show, :id => @user
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
    it "assigns the requested user as @user" do
      get :edit, :id => @user
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = {:username => 'username',:real_name => 'test user',:password => 'password',:password_confirmation => 'password'}
    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :user => @attr
        end.should change(User,:count).by(1)
      end

      it "redirects to the created user" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :user => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @attr = {:username => 'updated username'}
    end

    describe "with valid params" do
      it "updates the requested user" do
        put :update, :id => @user, :user => @attr 
        @user.reload
        @user.username.should == @attr[:username]
      end


      it "redirects to the user" do
        put :update, :id => @user,:user => @attr
        response.should redirect_to(user_path(@user))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @user,:user => {:username => nil}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      lambda do
        delete :destroy, :id => @user 
      end.should change(User,:count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, :id => @user 
      response.should redirect_to(users_url)
    end
  end
end

