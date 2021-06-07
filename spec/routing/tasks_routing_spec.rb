require "spec_helper"

describe TasksController do
  describe "routing" do

    it "routes to #index" do
      get("/tasks").should route_to("tasks#index")
    end

    it "routes to #new" do
      get("/tasks/new").should route_to("tasks#new")
    end

    it "routes to #show" do
      get("/tasks/1").should route_to("tasks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tasks/1/edit").should route_to("tasks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tasks").should route_to("tasks#create")
    end

    it "routes to #update" do
      put("/tasks/1").should route_to("tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tasks/1").should route_to("tasks#destroy", :id => "1")
    end

  end
end
