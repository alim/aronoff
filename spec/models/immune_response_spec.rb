require 'spec_helper'

describe ImmuneResponse do
  #include_context 'immune_response_setup'

  ## METHOD CHECKS -----------------------------------------------------
  describe "Should respond to all accessor methods" do
    it { should respond_to(:experiment_id) }
    it { should respond_to(:strain_name) }
    it { should respond_to(:cell_type) }
    it { should respond_to(:model) }
    it { should respond_to(:compartment) }
    it { should respond_to(:time_point) }
    it { should respond_to(:moi) }
    it { should respond_to(:strain_status) }
    it { should respond_to(:treatment) }
    it { should respond_to(:dose) }
    it { should respond_to(:result) }
    it { should respond_to(:cyto_chemo_kine) }
    it { should respond_to(:units) }
    it { should respond_to(:notes) }
  end

  ## VALIDATION CHECKS -------------------------------------------------

  describe "Validation checks" do
    before(:each){
      @user = FactoryGirl.create(:user)
      @project = FactoryGirl.create(:project, user: @user)
      @iresponse = FactoryGirl.create(:immune_response, user: @user, project: @project)
    }

    after(:each){
      ImmuneResponse.destroy_all
      User.destroy_all
      Project.destroy_all
    }

    it "should be valid, if no project" do
      @iresponse.project = nil
      @iresponse.should be_valid
    end

    it "should be valid, with project" do
      @iresponse.should be_valid
    end

    describe "invalid checks" do

      it "should not be valid, if not associated with a user" do
        @iresponse.user = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if experiment_id is missing" do
        @iresponse.experiment_id = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if experiment_id is duplicated" do
        @iresponse2 = ImmuneResponse.new(
          experiment_id: @iresponse.experiment_id,
          strain_name: @iresponse.strain_name,
          cell_type: @iresponse.cell_type,
          user: @user)
        @iresponse2.should_not be_valid
      end

      it "should not be valid, if strain_name is missing" do
        @iresponse.strain_name = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if cell_type is missing" do
        @iresponse.cell_type = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if cell_type out of range" do
        @iresponse.cell_type = 9999
        @iresponse.should_not be_valid
      end

      it "should not be valid, if model is missing" do
        @iresponse.model = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if model out of range" do
        @iresponse.model = 9999
        @iresponse.should_not be_valid
      end

      it "should not be valid, if compartment is missing" do
        @iresponse.compartment = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if compartment out of range" do
        @iresponse.compartment = 9999
        @iresponse.should_not be_valid
      end

      it "should not be valid, if strain_status is missing" do
        @iresponse.strain_status = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if strain_status out of range" do
        @iresponse.strain_status = 100
        @iresponse.should_not be_valid
      end

       it "should not be valid, if treatment is missing" do
        @iresponse.treatment = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if treatment out of range" do
        @iresponse.treatment = 100
        @iresponse.should_not be_valid
      end

      it "should not be valid, if result is missing" do
        @iresponse.result = nil
        @iresponse.should_not be_valid
      end

       it "should not be valid, if cyto_chemo_kine is missing" do
        @iresponse.cyto_chemo_kine = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if cyto_chemo_kine out of range" do
        @iresponse.cyto_chemo_kine = 53
        @iresponse.should_not be_valid
      end

      it "should not be valid, if units is missing" do
        @iresponse.units = nil
        @iresponse.should_not be_valid
      end

      it "should not be valid, if units out of range" do
        @iresponse.units = 53
        @iresponse.should_not be_valid
      end
    end # Invalid checks

  end # Validation checks

  ## SCOPE CHECKS ------------------------------------------------------

  #describe "Scope checks" do
    #before(:each){
      #iresponse_project
    #}
#
    #after(:each){
      #User.destroy_all
      #iresponse.destroy_all
      #Group.destroy_all
      #Project.destroy_all
    #}
#
    #it "should allow searching by exact strain_name" do
      #sname = iresponse.last.strain_name
      #mac = iresponse.by_strain(sname)
      #mac.count.should eq(1)
      #mac.first.strain_name.should eq(sname)
    #end
#
    #it "should allow seacrching by partial strain_name" do
      #sname = iresponse.last.strain_name
      #mac = iresponse.by_strain(sname[0..2])
      #mac.count.should > 1
      #mac.each do |mac|
        #mac.strain_name.should match(/#{sname[0..2]}/)
      #end
    #end
#
    #it "should allow searching by exact experiment_id" do
      #eid = iresponse.last.experiment_id
      #mac = iresponse.by_experiment(eid)
      #mac.count.should eq(1)
      #mac.first.experiment_id.should eq(eid)
    #end
#
    #it "should allow seacrching by partial experiment id" do
      #eid = iresponse.last.experiment_id
      #mac = iresponse.by_experiment(eid[0..8])
      #mac.count.should > 1
      #mac.each do |mac|
        #mac.experiment_id.should match(/#{eid[0..8]}/)
      #end
    #end
#
    #it "should allow searching by exact macrohpage_type" do
      #mid = iresponse.last.iresponse_type
      #mac = iresponse.by_iresponse(mid)
      #mac.count.should >= 1
      #mac.first.iresponse_type.should eq(mid)
    #end
  #end

  ## find_with_groups --------------------------------------------------

  #describe "Find_with_groups method tests" do
#
    #describe "Single project, single group, multiple members" do
      #before(:each) {
        #iresponse_project
        #@diff_user = User.where(:id.ne => @user.id ).first
      #}
#
      #after(:each) {
        #User.destroy_all
        #iresponse.destroy_all
        #Group.destroy_all
        #Project.destroy_all
      #}
#
      #it "should not return empty results for iresponse owner" do
        #mac_list = iresponse.find_with_groups(@user)
        #mac_list.count.should_not eq(0)
      #end
#
      #it "should not return empty results for a group member" do
        #mac_list = iresponse.find_with_groups(@diff_user)
        #mac_list.count.should_not eq(0)
      #end
#
      #it "should return all owned iresponse records for owner" do
        #original_mac_list = iresponse.all.pluck(:id).sort
        #mac_list = iresponse.find_with_groups(@user).pluck(:id).sort
      #end
#
      #it "should return all owned iresponse records for group member" do
        #original_mac_list = iresponse.all.pluck(:id).sort
        #mac_list = iresponse.find_with_groups(@diff_user).pluck(:id).sort
      #end
#
      #it "should NOT find any iresponse records for non-group member" do
        #new_user = FactoryGirl.create(:user)
        #mac_list = iresponse.find_with_groups(new_user)
        #mac_list.should be_empty
      #end
    #end
#
  #end
end
