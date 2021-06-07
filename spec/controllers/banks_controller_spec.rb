# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe BanksController do
  login_admin
  render_views

  before(:each) do
    @bank = Factory(:icbc)
  end


  describe "GET index" do
    it "assigns all banks as @banks" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do

    it "should be success" do
      get :show, :id => @bank
      response.should be_success
    end

    it "assigns the requested computer_bill as @computer_bill" do
      get :show, :id => @bank
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
    it "should render 'edit' template" do
      get :edit, :id => @bank
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:bank).attributes
    end
    describe "success" do
      it "能够成功保存银行信息" do
        lambda do
          post :create, :bank => @attr
        end.should change(Bank,:count).by(1)
      end

      it "redirects to the created bank" do
        post :create, :bank => @attr
        response.should redirect_to(bank_path(assigns(:bank)))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :bank => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @attr = {:name => 'update bank name'}
    end

    describe "with valid params" do
      it "updates the requested computer_bill" do
        put :update, :id => @bank, :bank => @attr 
        @bank.reload
        @bank.name.should == @attr[:name]
      end


      it "redirects to the bank" do
        put :update, :id => @bank,:bank => @attr
        response.should redirect_to(bank_path(@bank))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @bank,:bank => {:name => nil}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested bank" do
      lambda do
        delete :destroy, :id => @bank
      end.should change(Bank,:count).by(-1)
    end

    it "redirects to the banks list" do
      delete :destroy, :id => @bank
      response.should redirect_to(banks_url)
    end
  end

end

