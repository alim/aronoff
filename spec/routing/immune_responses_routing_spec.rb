require "spec_helper"

describe ImmuneResponsesController do
  describe "routing" do

    it "routes to #index" do
      get("/immune_responses").should route_to("immune_responses#index")
    end

    it "routes to #new" do
      get("/immune_responses/new").should route_to("immune_responses#new")
    end

    it "routes to #show" do
      get("/immune_responses/1").should route_to("immune_responses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/immune_responses/1/edit").should route_to("immune_responses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/immune_responses").should route_to("immune_responses#create")
    end

    it "routes to #update" do
      put("/immune_responses/1").should route_to("immune_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/immune_responses/1").should route_to("immune_responses#destroy", :id => "1")
    end

  end
end
