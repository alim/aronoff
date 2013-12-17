require 'spec_helper'

describe "ImmuneResponses" do
  describe "GET /immune_responses" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get immune_responses_path
      response.status.should be(200)
    end
  end
end
