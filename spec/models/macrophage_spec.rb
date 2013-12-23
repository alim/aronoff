require 'spec_helper'

describe Macrophage do
  include_context 'macrophage_setup'

  ## METHOD CHECKS -----------------------------------------------------
  describe "Should respond to all accessor methods" do
    it { should respond_to(:strain_name) }
    it { should respond_to(:experiment_id) }
    it { should respond_to(:macrophage_type) }
    it { should respond_to(:treatment) }
    it { should respond_to(:dose) }
    it { should respond_to(:data) }
    it { should respond_to(:data_type) }
    it { should respond_to(:notes) }
  end

  ## VALIDATION CHECKS -------------------------------------------------

  describe "Validation checks" do
    before(:each){
      user = FactoryGirl.create(:user)
      @macrophage = FactoryGirl.create(:macrophage, user: user)
    }

    after(:each){
      Macrophage.destroy_all
    }

    it "should be valid, if no project" do
      @macrophage.should be_valid
    end

    describe "invalid checks" do

      it "should not be valid, if not associated with a user" do
        @macrophage.user = nil
        @macrophage.should_not be_valid
      end

      it "should not be valid, if strain_name is missing" do
        @macrophage.strain_name = nil
        @macrophage.should_not be_valid
      end

       it "should not be valid, if experiment_id is missing" do
        @macrophage.experiment_id = nil
        @macrophage.should_not be_valid
      end

       it "should not be valid, if macrophage_type is missing" do
        @macrophage.macrophage_type = nil
        @macrophage.should_not be_valid
      end

       it "should not be valid, if treatment is missing" do
        @macrophage.treatment = nil
        @macrophage.should_not be_valid
      end

      it "should not be valid, if dose is missing" do
        @macrophage.dose = nil
        @macrophage.should_not be_valid
      end

      it "should not be valid, if data is missing" do
        @macrophage.data = nil
        @macrophage.should_not be_valid
      end

      it "should not be valid, if data_type is missing" do
        @macrophage.data_type = nil
        @macrophage.should_not be_valid
      end

    end # Invalid checks

  end # Validation checks

  ## SCOPE CHECKS ------------------------------------------------------

  describe "Scope checks" do
    before(:each){
      macrophage_project
    }

    after(:each){
      User.destroy_all
      Macrophage.destroy_all
      Group.destroy_all
      Project.destroy_all
    }

    it "should allow searching by exact strain_name" do
      sname = Macrophage.last.strain_name
      mac = Macrophage.by_strain(sname)
      mac.count.should eq(1)
      mac.first.strain_name.should eq(sname)
    end

    it "should allow seacrching by partial strain_name" do
      sname = Macrophage.last.strain_name
      mac = Macrophage.by_strain(sname[0..2])
      mac.count.should > 1
      mac.each do |mac|
        mac.strain_name.should match(/#{sname[0..2]}/)
      end
    end

    it "should allow searching by exact experiment_id" do
      eid = Macrophage.last.experiment_id
      mac = Macrophage.by_experiment(eid)
      mac.count.should eq(1)
      mac.first.experiment_id.should eq(eid)
    end

    it "should allow seacrching by partial experiment id" do
      eid = Macrophage.last.experiment_id
      mac = Macrophage.by_experiment(eid[0..8])
      mac.count.should > 1
      mac.each do |mac|
        mac.experiment_id.should match(/#{eid[0..8]}/)
      end
    end

    it "should allow searching by exact macrohpage_type" do
      mid = Macrophage.last.macrophage_type
      mac = Macrophage.by_macrophage(mid)
      mac.count.should >= 1
      mac.first.macrophage_type.should eq(mid)
    end
  end

  ## HELPER METHOD TESTS -----------------------------------------------
  describe "Helper methods for printing attribute strings" do
    before(:each){
      macrophage_project
      @mac = Macrophage.last
    }

    after(:each){
      User.destroy_all
      Macrophage.destroy_all
      Group.destroy_all
      Project.destroy_all
    }

    it "should return the correct macrophage_type string" do
      @mac.macrophage_type = Macrophage::DMTERM
      @mac.macrophage_type_str.should match(/DM term/)
    end

    it "should return the correct treatment string" do
      @mac.treatment = Macrophage::PGE2
      @mac.treatment_str.should match(/PGE2/)
    end

    it "should return the correct macrophage_type string" do
      @mac.dose = Macrophage::Ten_uM
      @mac.dosage_str.should match(/10 um/)
    end

    it "should return the correct macrophage_type string" do
      @mac.data_type = Macrophage::NOMALIZED_PHAGO_ACTIVITY
      @mac.datatype_str.should match(/Normalized phago activity/)
    end
  end

  ## find_with_groups --------------------------------------------------

  describe "Find_with_groups method tests" do

    describe "Single project, single group, multiple members" do
      before(:each) {
        macrophage_project
        @diff_user = User.where(:id.ne => @user.id ).first
      }

      after(:each) {
        User.destroy_all
        Macrophage.destroy_all
        Group.destroy_all
        Project.destroy_all
      }

      it "should not return empty results for Macrophage owner" do
        mac_list = Macrophage.find_with_groups(@user)
        mac_list.count.should_not eq(0)
      end

      it "should not return empty results for a group member" do
        mac_list = Macrophage.find_with_groups(@diff_user)
        mac_list.count.should_not eq(0)
      end

      it "should return all owned Macrophage records for owner" do
        original_mac_list = Macrophage.all.pluck(:id).sort
        mac_list = Macrophage.find_with_groups(@user).pluck(:id).sort
      end

      it "should return all owned Macrophage records for group member" do
        original_mac_list = Macrophage.all.pluck(:id).sort
        mac_list = Macrophage.find_with_groups(@diff_user).pluck(:id).sort
      end

      it "should NOT find any Macrophage records for non-group member" do
        new_user = FactoryGirl.create(:user)
        mac_list = Macrophage.find_with_groups(new_user)
        mac_list.should be_empty
      end
    end

  end
end
