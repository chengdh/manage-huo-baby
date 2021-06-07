require "spec_helper"

describe CustomerPaymentInfosController do
  describe "routing" do

    it "routes to #index" do
      get("/customer_payment_infos").should route_to("customer_payment_infos#index")
    end

    it "routes to #new" do
      get("/customer_payment_infos/new").should route_to("customer_payment_infos#new")
    end

    it "routes to #show" do
      get("/customer_payment_infos/1").should route_to("customer_payment_infos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/customer_payment_infos/1/edit").should route_to("customer_payment_infos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/customer_payment_infos").should route_to("customer_payment_infos#create")
    end

    it "routes to #update" do
      put("/customer_payment_infos/1").should route_to("customer_payment_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/customer_payment_infos/1").should route_to("customer_payment_infos#destroy", :id => "1")
    end

  end
end
