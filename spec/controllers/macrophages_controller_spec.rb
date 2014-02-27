require 'spec_helper'

describe MacrophagesController do
  include_context 'macrophage_setup'

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MacrophagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  ## TEST SETUP --------------------------------------------------------
  let(:tags) {'tag1,tag2,tag3,tag4'}
  let(:valid_params){
    {
      strain_name: 'Ecoli-12341234',
      experiment_id: "ControllerTest-#{rand(100..100000)}",
      macrophage_type: Macrophage::DMTERM,
      treatment: Macrophage::LTB4,
      dose: Macrophage::One_uM,
      data: 12341234.11,
      data_type: Macrophage::NUM_PER_THP1_CELL,
      notes: "Controller testing parameter for notes",
      tags: tags.split
    }
  }

  before(:each) {
    macrophage_project_groups

    # Sign in as the owner
    sign_in @owner
  }

  after(:each) {
    User.destroy_all
    Project.destroy_all
    Macrophage.destroy_all
    Group.destroy_all
  }

  # INDEX TESTS --------------------------------------------------------

  describe "GET index" do
    let(:pull_ids) {
      @mids = []
      @macrophages.each {|mac| @mids << mac.id}
      @mids = @mids.sort
    }

    let(:group_check) {
      gids = @owner.groups.pluck(:id).sort.uniq
      macrophages = assigns(:macrophages)

      projects = []
      macrophages.each {|mac| projects << mac.project}
      projects.uniq!

      group_ids = []
      projects.each {|project| group_ids << project.groups.pluck(:id)}
      group_ids.uniq!

      common_group_ids = group_ids[0] & gids
      common_group_ids.count.should_not eq(0)
    }

    describe "with no search criteria" do

      it "assigns all macrophages as @macrophages w/o search parameters" do
        get :index
        assigns(:macrophages).count.should eq(ApplicationController::PAGE_COUNT)
      end

      it "should identify all macrophages" do
        ids = Macrophage.all.pluck(:id).sort.uniq
        get :index
        @macrophages = assigns(:macrophages)
        pull_ids
        @mids.should eq(ids)
      end

      it "should only show records that are part of the group" do
        get :index
        group_check
      end

    end

    describe "with search by experiment_id" do

      it "finds only macrophages with matching experiment_id" do
        @search = Macrophage.last.experiment_id
        @macs = Macrophage.by_experiment(@search)

        get :index

        @macs.count.should > 0
        @macs.each {|mac| mac.experiment_id.should eq(@search)}
      end

      it "should only show records that are part of the group" do
        @search = Macrophage.last.experiment_id
        @macs = Macrophage.by_experiment(@search)

        get :index
        group_check
      end


      it "finds not find any macrophages without matching experiment_id" do
        @search = "9999999999999"
        @macs = Macrophage.by_experiment(@search)

        get :index

        @macs.count.should == 0
      end

    end

    describe "with search by strain_name" do
      it "finds only macrophages with matching strain_name" do
        @search = Macrophage.last.strain_name
        @macs = Macrophage.by_strain(@search)

        get :index

        @macs.count.should > 0
        @macs.each {|mac| mac.strain_name.should eq(@search)}
      end

      it "should only show records that are part of the group" do
        @search = Macrophage.last.strain_name
        @macs = Macrophage.by_strain(@search)

        get :index
        group_check
      end


      it "finds not find any macrophages without matching strain_name" do
        @search = "9999999999999"
        @macs = Macrophage.by_strain(@search)

        get :index

        @macs.count.should == 0
      end
    end

    describe "with search by macrophage_type" do
      it "finds only macrophages with matching macrophage_type" do
        @search = Macrophage.last.macrophage_type
        @macs = Macrophage.by_macrophage(@search)

        get :index

        @macs.count.should > 0
        @macs.each {|mac| mac.macrophage_type.should eq(@search)}
      end

      it "should only show records that are part of the group" do
        @search = Macrophage.last.macrophage_type
        @macs = Macrophage.by_macrophage(@search)

        get :index
        group_check
      end

      it "finds not find any macrophages without matching macrophage_type" do
        @search = 999
        @macs = Macrophage.by_macrophage(@search)

        get :index

        @macs.count.should == 0
      end
    end
  end

  # SHOW TESTS ---------------------------------------------------------

  describe "GET show" do
    it "assigns the requested macrophage as @macrophage" do
      macrophage = Macrophage.last
      get :show, {id: macrophage.to_param}
      assigns(:macrophage).should eq(macrophage)
    end
  end

  # NEW TESTS ----------------------------------------------------------

  describe "GET new" do
    it "assigns a new macrophage as @macrophage" do
      get :new
      assigns(:macrophage).should be_a_new(Macrophage)
    end
  end

  # EDIT TESTS ---------------------------------------------------------

  describe "GET edit" do
    it "assigns the requested macrophage as @macrophage" do
      macrophage = Macrophage.first
      get :edit, {:id => macrophage.to_param}, valid_session
      assigns(:macrophage).should eq(macrophage)
    end
  end

  # CREATE TESTS -------------------------------------------------------

  describe "POST create" do

    describe "with valid params" do

      it "creates a new Macrophage" do
        expect {
          post :create, {:macrophage => valid_params}, valid_session
        }.to change(Macrophage, :count).by(1)
      end

      it "assigns a newly created macrophage as @macrophage" do
        post :create, {:macrophage => valid_params}, valid_session
        assigns(:macrophage).should be_a(Macrophage)
        assigns(:macrophage).should be_persisted
      end

      it "redirects to the created macrophage" do
        post :create, {:macrophage => valid_params}, valid_session
        response.should redirect_to(Macrophage.last)
      end

      it "assigns the correct tags" do
        post :create, {macrophage: valid_params}
        assigns(:macrophage).tags.should eq(tags)
      end

      it "assings both existing and new tags" do
        tag_list = tags + ',tag99,tag100'
        post :create, {macrophage: valid_params, new_tags: 'tag99,tag100'}
        assigns(:macrophage).tags.should eq(tag_list)
      end    
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved macrophage as @macrophage" do
        params = valid_params
        params[:macrophage_type] = nil # Invalid type

        post :create, {macrophage: params}, valid_session
        assigns(:macrophage).should be_a_new(Macrophage)
      end

      it "should not increate the number of Macrophages" do
        params = valid_params
        params[:macrophage_type] = nil # Invalid type
        expect {
          post :create, {macrophage: params}, valid_session
        }.to change(Macrophage, :count).by(0)
      end

      it "re-renders the 'new' template" do
        params = valid_params
        params[:macrophage_type ]= nil # Invalid type

        post :create, {macrophage: params}, valid_session
        response.should render_template("new")
      end
    end
  end

  # UPDATE TESTS -------------------------------------------------------

  describe "PUT update" do
    before(:each){
      @macrophage = Macrophage.where(user_id: @owner.id).first
    }

    describe "with valid params" do
      it "updates the requested macrophage" do
        Macrophage.any_instance.should_receive(:update).with({ "strain_name" => valid_params[:strain_name] })
        put :update, {id: @macrophage.to_param, macrophage: { "strain_name" =>  valid_params[:strain_name]}}
      end

      it "assigns the requested macrophage as @macrophage" do
        put :update, {id: @macrophage.to_param, :macrophage => valid_params}, valid_session
        assigns(:macrophage).should eq(@macrophage)
      end

      it "redirects to the macrophage" do
        put :update, {id: @macrophage.to_param, :macrophage => valid_params}, valid_session
        response.should redirect_to(@macrophage)
      end
    end

    describe "with invalid params" do
      before(:each){
        @invalid_params = valid_params
        @invalid_params[:strain_name] = nil
      }

      it "assigns the macrophage as @macrophage" do
        put :update, {id: @macrophage.to_param, macrophage: @invalid_params}, valid_session
        assigns(:macrophage).should eq(@macrophage)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Macrophage.any_instance.stub(:save).and_return(false)
        put :update, {id: @macrophage.to_param, macrophage: @invalid_params}, valid_session
        response.should render_template("edit")
      end
    end
  end

  # DESTROY TESTS ------------------------------------------------------

  describe "DELETE destroy" do
    before(:each){
      @macrophage = Macrophage.where(user_id: @owner.id).first
    }

    it "destroys the requested macrophage" do
      expect {
        delete :destroy, {id: @macrophage.to_param}, valid_session
      }.to change(Macrophage, :count).by(-1)
    end

    it "redirects to the macrophages list" do
      delete :destroy, {id: @macrophage.to_param}, valid_session
      response.should redirect_to(macrophages_url)
    end
  end

end
