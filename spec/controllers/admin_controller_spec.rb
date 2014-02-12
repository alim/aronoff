require 'spec_helper'

describe AdminController do
  include_context 'macrophage_setup'

  describe "dashboard actions" do
    before(:each) {
      macrophage_project
      5.times.each { FactoryGirl.create(:immune_response, user: @owner) }
      sign_in @owner
    }

    it "dashboard - index should show both macrophages and immune_response records" do
      get :index
      assigns(:immune_responses).count.should eq(ImmuneResponse.count)
      assigns(:macrophages).count.should eq(Macrophage.count)
    end

    it "should show now records, if not owner or group member" do
      newuser = FactoryGirl.create(:user)
      sign_out @owner
      sign_in newuser
      get :index
      assigns(:immune_responses).count.should == 0
      assigns(:macrophages).count.should == 0
    end
    
  end

end
