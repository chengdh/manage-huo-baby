# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe TransitCompaniesController do
  login_admin
  render_views

  before(:each) do
    @transit_company = Factory(:transit_company)
  end


  describe "GET index" do
    it "assigns all transit_companys as @transit_companys" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do

    it "should be success" do
      get :show, :id => @transit_company
      response.should be_success
    end

    it "assigns the requested transit_company as @transit_company" do
      get :show, :id => @transit_company
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
    it "assigns the requested transit_company as @transit_company" do
      get :edit, :id => @transit_company
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:transit_company).attributes
    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :transit_company => @attr
        end.should change(TransitCompany,:count).by(1)
      end

      it "redirects to the created transit_company" do
        post :create, :transit_company => @attr
        response.should redirect_to(transit_company_path(assigns(:transit_company)))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :transit_company => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @attr = {:name => 'changed name'}
    end

    describe "with valid params" do
      it "updates the requested transit_company" do
        put :update, :id => @transit_company, :transit_company => @attr 
        @transit_company.reload
        @transit_company.name.should == @attr[:name]
      end


      it "redirects to the transit_company" do
        put :update, :id => @transit_company,:transit_company => @attr
        response.should redirect_to(transit_company_path(@transit_company))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @transit_company,:transit_company => {:name => nil}
        response.should render_template("edit")
      end
    end
  end
end

