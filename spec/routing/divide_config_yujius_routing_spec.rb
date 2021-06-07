require "spec_helper"

describe DivideConfigYujiusController do
  describe "routing" do

    it "routes to #index" do
      get("/divide_config_yujius").should route_to("divide_config_yujius#index")
    end

    it "routes to #new" do
      get("/divide_config_yujius/new").should route_to("divide_config_yujius#new")
    end

    it "routes to #show" do
      get("/divide_config_yujius/1").should route_to("divide_config_yujius#show", :id => "1")
    end

    it "routes to #edit" do
      get("/divide_config_yujius/1/edit").should route_to("divide_config_yujius#edit", :id => "1")
    end

    it "routes to #create" do
      post("/divide_config_yujius").should route_to("divide_config_yujius#create")
    end

    it "routes to #update" do
      put("/divide_config_yujius/1").should route_to("divide_config_yujius#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/divide_config_yujius/1").should route_to("divide_config_yujius#destroy", :id => "1")
    end

  end
end
