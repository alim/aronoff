require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'by_bacteria'" do
    it "returns http success" do
      get 'by_bacteria'
      response.should be_success
    end
  end

  describe "GET 'by_user'" do
    it "returns http success" do
      get 'by_user'
      response.should be_success
    end
  end

  describe "GET 'by_date'" do
    it "returns http success" do
      get 'by_date'
      response.should be_success
    end
  end

end
