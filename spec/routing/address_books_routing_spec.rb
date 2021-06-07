require "spec_helper"

describe AddressBooksController do
  describe "routing" do

    it "routes to #index" do
      get("/address_books").should route_to("address_books#index")
    end

    it "routes to #new" do
      get("/address_books/new").should route_to("address_books#new")
    end

    it "routes to #show" do
      get("/address_books/1").should route_to("address_books#show", :id => "1")
    end

    it "routes to #edit" do
      get("/address_books/1/edit").should route_to("address_books#edit", :id => "1")
    end

    it "routes to #create" do
      post("/address_books").should route_to("address_books#create")
    end

    it "routes to #update" do
      put("/address_books/1").should route_to("address_books#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/address_books/1").should route_to("address_books#destroy", :id => "1")
    end

  end
end
