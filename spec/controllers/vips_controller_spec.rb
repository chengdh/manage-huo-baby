# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe VipsController do
  login_admin
  render_views

  describe "GET index" do
    it "assigns all vips as @vips" do
      @vip = Factory(:vip)
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "should be success" do

      @vip = Factory(:vip)
      get :show, :id => @vip
      response.should be_success
    end

    it "assigns the requested vip as @vip" do

      @vip = Factory(:vip)
      get :show, :id => @vip
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
    it "assigns the requested vip as @vip" do

      @vip = Factory(:vip)
      get :edit, :id => @vip
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:vip).attributes
      @attr.delete_if {|key,value| key=='type' or key=='id' or key=='code'}

    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :vip => @attr
        end.should change(Vip,:count).by(1)
      end

      it "redirects to the created vip" do
        post :create, :vip => @attr
        response.should redirect_to(vip_path(assigns(:vip)))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :vip => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @vip = Factory(:vip)
      @attr = {:note => 'update vip info'}
    end

    describe "with valid params" do
      it "updates the requested vip" do
        put :update, :id => @vip, :vip => @attr
        @vip.reload
        @vip.note.should == @attr[:note]
      end


      it "redirects to the vip" do
        put :update, :id => @vip,:vip => @attr
        response.should redirect_to(vip_path(@vip))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @vip,:vip => {:name => nil}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    before :each do
      @vip = Factory(:vip)
    end
    it "destroys the requested vip" do
      lambda do
        delete :destroy, :id => @vip
      end.should change(Vip,:count).by(-1)
    end

    it "redirects to the vips list" do
      delete :destroy, :id => @vip
      response.should redirect_to(vips_url)
    end
  end
  describe "GET search" do
    it "should be success" do
      get :search
      response.should be_success
    end
    it "should render 'search'" do
      get :search
      response.should render_template('search')
    end
  end
end

