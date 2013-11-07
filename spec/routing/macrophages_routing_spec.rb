require "spec_helper"

describe MacrophagesController do
  describe "routing" do

    it "routes to #index" do
      get("/macrophages").should route_to("macrophages#index")
    end

    it "routes to #new" do
      get("/macrophages/new").should route_to("macrophages#new")
    end

    it "routes to #show" do
      get("/macrophages/1").should route_to("macrophages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/macrophages/1/edit").should route_to("macrophages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/macrophages").should route_to("macrophages#create")
    end

    it "routes to #update" do
      put("/macrophages/1").should route_to("macrophages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/macrophages/1").should route_to("macrophages#destroy", :id => "1")
    end

  end
end
