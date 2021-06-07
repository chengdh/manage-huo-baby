# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ComputerBillsController do
  login_admin
  render_views

  describe "GET index" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end

    it "assigns all computer_bills as @computer_bills" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end


    it "should be success" do
      get :show, :id => @computer_bill
      response.should be_success
    end

    it "assigns the requested computer_bill as @computer_bill" do
      get :show, :id => @computer_bill
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
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end

    it "assigns the requested computer_bill as @computer_bill" do
      get :edit, :id => @computer_bill
      response.should render_template('edit')
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:computer_bill).attributes
      delete_attrs = %w[goods_no bill_no original_carrying_fee original_goods_fee original_from_short_carrying_fee insured_rate original_insured_amount id type original_insured_fee original_to_short_carrying_fee original_carrying_fee]
      @attr.delete_if { |key,value| delete_attrs.include?(key)}
    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :computer_bill => @attr
        end.should change(ComputerBill,:count).by(1)
      end

      it "redirects to the created computer_bill" do
        post :create, :computer_bill => @attr
        response.should redirect_to(computer_bill_path(assigns(:computer_bill)))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :computer_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    before :each do

      @computer_bill = Factory(:computer_bill)
      @attr = {:goods_info => 'change_goods_info',:from_customer_name => 'changed customer name'}
    end

    describe "with valid params" do
      it "updates the requested computer_bill" do
        put :update, :id => @computer_bill, :computer_bill => @attr
        @computer_bill.reload
        @computer_bill.goods_info.should == @attr[:goods_info]
        @computer_bill.from_customer_name.should == @attr[:from_customer_name]
      end


      it "redirects to the computer_bill" do
        put :update, :id => @computer_bill,:computer_bill => @attr
        response.should redirect_to(computer_bill_path(@computer_bill))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, :id => @computer_bill,:computer_bill => {:from_org_id => nil}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      @computer_bill = Factory(:computer_bill)
    end

    it "destroys the requested computer_bill" do
      lambda do
        delete :destroy, :id => @computer_bill
      end.should change(ComputerBill,:count).by(-1)
    end

    it "redirects to the computer_bills list" do
      delete :destroy, :id => @computer_bill
      response.should redirect_to(root_url)
    end
  end
  describe "GET search" do
    it "should be success" do
      get :search,:format => :js
      response.should be_success
    end
    it "should render '/shared/carrying_bills/search'" do
      get :search,:format => :js
      response.should render_template('shared/carrying_bills/_search')
    end
  end
  #打印计数
  describe "PUT print_counter" do
    before :each do
      @computer_bill = Factory(:computer_bill)
    end
    it "after print shoud increment the print counter column" do
      lambda do
        put :print_counter,:id => @computer_bill
        @computer_bill.reload
      end.should change(@computer_bill,:print_counter).by(1)
    end
  end
end

