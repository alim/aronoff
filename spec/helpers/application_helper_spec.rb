require 'spec_helper'

describe ApplicationHelper do
  describe "#active method tests" do
    it "should return active string, if the path matches" do
      helper.request.path = admin_path
      helper.active(admin_path).should == "active"
    end

    it "should return empty string, if the path does not match" do
      helper.request.path = 'some_path'
      helper.active(admin_path).should be_empty
    end
  end
end
