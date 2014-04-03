require 'spec_helper'

describe ApplicationHelper do
  describe "#active method tests" do
    it "should return active string, if the path matches" do
      helper.request.path = admin_path
      helper.active(admin_path).should == "active"
    end

    it "if group path and settings selected, should return active" do
      helper.request.path = groups_path
      helper.active('/settings').should == "active"
    end

    it "if project path and settings selected, should return active" do
      helper.request.path = projects_path
      helper.active('/settings').should == "active"
    end

    it "if edit user path and settings selected, should return active" do
      helper.request.path = edit_user_registration_path
      helper.active('/settings').should == "active"
    end

    it "should return empty string, if the path does not match" do
      helper.request.path = 'some_path'
      helper.active(admin_path).should be_nil
    end
  end

  describe "#tag_options_list" do
    before(:each){
      user = create :user
      @immune = create(:immune_response, user: user)
      @macrophage = create(:macrophage, user: user)
    }

    it "should return a list of options " do
      helper.tag_options_list.should == options_for_select((@immune.tags.split(',') +
        @macrophage.tags.split(',')).uniq.sort)
    end

    it "should return empty options if no tags" do
      @immune.tags = nil
      @immune.save
      @macrophage.tags = nil
      @macrophage.save
      helper.tag_options_list.should == options_for_select([])
    end

    it "should set selected tags" do
      tag = @immune.tags.split(',').first
      @macrophage.tags = tag
      @macrophage.save
      helper.tag_options_list(@macrophage).should include "<option selected=\"selected\" value=\"#{tag}\">#{tag}</option>"
    end
  end
end
