require 'spec_helper'

describe SearchController do
  include_context 'search_setup'

  # TEST SETUP --------------------------------------------------------
  let(:signout_result_check) {
    response.should redirect_to new_user_session_url
  }

  # SEARCH BY BACTERIA TESTS ------------------------------------------
  describe "GET bacteria" do

    it "should return success" do
      signin_customer
      get :bacteria
      response.should be_success
    end

    it "should redirect to to sign in if NOT signed in" do
      get :bacteria
      signout_result_check
    end
  end

  describe "POST 'by_bacteria'" do
    before(:each) {
      strain_search_data
    }

    it "returns http success" do
      post :by_bacteria
      response.should be_success
    end

    it "should find the correct number of macrophage records" do
      post :by_bacteria, strain_name: @strain_name
      assigns(:macrophages).count.should eq(@mac_count)
    end

    it "should find the correct number of immune response records" do
      post :by_bacteria, strain_name: @strain_name
      assigns(:immune_responses).count.should eq(@ir_count)
    end

    it "should redirect to to sign in if NOT signed in" do
      sign_out @signed_in_user
      post :bacteria
      signout_result_check
    end    
  end

  describe "POST 'by_user'" do
    it "returns http success" do
      pending
      post 'by_user'
      response.should be_success
    end
  end

  describe "POST 'by_date'" do
    it "returns http success" do
      pending
      post 'by_date'
      response.should be_success
    end
  end

end
