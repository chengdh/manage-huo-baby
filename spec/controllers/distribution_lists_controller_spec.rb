# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe DistributionListsController do
  login_admin
  render_views

  describe "POST create" do
    before(:each) do
      @computer_bill = Factory(:computer_bill_reached)
    end

    describe "with valid params" do
      it "should success create distribution list" do
        lambda do
          post :create, :distribution_list => {'org_id' => Factory(:zz)},:bill_ids => [@computer_bill.id]
        end.should change(DistributionList,:count).by(1)
      end

      it "redirects to the created distribution_list" do
        post :create, :distribution_list => {'org_id' => Factory(:zz)},:bill_ids => [@computer_bill.id]
        response.should redirect_to(assigns[:distribution_list])
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :distribution_list => {'org_id' => nil},:bill_ids => [@computer_bill.id]
        response.should render_template("new")
      end
    end

  end
end

