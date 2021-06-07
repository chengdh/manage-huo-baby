require "spec_helper"

describe DivideRptYujiusController do
  describe "routing" do

    it "routes to #index" do
      get("/divide_rpt_yujius").should route_to("divide_rpt_yujius#index")
    end

    it "routes to #new" do
      get("/divide_rpt_yujius/new").should route_to("divide_rpt_yujius#new")
    end

    it "routes to #show" do
      get("/divide_rpt_yujius/1").should route_to("divide_rpt_yujius#show", :id => "1")
    end

    it "routes to #edit" do
      get("/divide_rpt_yujius/1/edit").should route_to("divide_rpt_yujius#edit", :id => "1")
    end

    it "routes to #create" do
      post("/divide_rpt_yujius").should route_to("divide_rpt_yujius#create")
    end

    it "routes to #update" do
      put("/divide_rpt_yujius/1").should route_to("divide_rpt_yujius#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/divide_rpt_yujius/1").should route_to("divide_rpt_yujius#destroy", :id => "1")
    end

  end
end
