require 'spec_helper'

describe ImmuneResponsesController do
  include_context 'immune_response_setup'

  # Test setup ---------------------------------------------------------

  before(:each) {
    immune_responses_project
    sign_in @owner
  }

  # INDEX TESTS --------------------------------------------------------

  describe "GET index" do
    let(:pull_ids) {
      @immune_ids = []
      @immune_responses.each {|immune_response| @immune_ids << immune_response.id}
      @immune_ids = @immune_ids.sort
    }

    let(:group_check) {
      gids = @owner.groups.pluck(:id).sort.uniq
      immune_responses = assigns(:immune_responses)

      projects = []
      immune_responses.each {|iresponse| projects << iresponse.project}
      projects.uniq!

      group_ids = []
      projects.each {|project| group_ids << project.groups.pluck(:id)}
      group_ids.uniq!

      common_group_ids = group_ids[0] & gids
      common_group_ids.count.should_not eq(0)
    }

    describe "Index list without search criteria" do

      it "assigns all immune_responses as @immune_responses" do
        get :index
        count = ImmuneResponse.all.count
        count = ApplicationController::PAGE_COUNT if count > ApplicationController::PAGE_COUNT
        assigns(:immune_responses).count.should eq(count)
      end

      it "should identify all immune esponses" do
        ids = ImmuneResponse.all.pluck(:id).sort.uniq
        get :index
        @immune_responses = assigns(:immune_responses)
        pull_ids
        @immune_ids.should eq(ids)
      end

      it "should only show records that are part of the group" do
        get :index
        group_check
      end
    end # no search criteria

    describe "with search by experiment_id" do

      it "finds only immune responses with matching experiment_id" do
        @search = ImmuneResponse.last.experiment_id
        @immune_responses = ImmuneResponse.by_experiment(@search)

        get :index

        @immune_responses.count.should > 0
        @immune_responses.each {|iresponse| iresponse.experiment_id.should eq(@search)}
      end

      it "should only show records that are part of the group" do
        @search = ImmuneResponse.last.experiment_id
        @immune_responses = ImmuneResponse.by_experiment(@search)

        get :index
        group_check
      end

      it "finds not find any immune responses without matching experiment_id" do
        @search = "9999999999999"
        @immune_responses = ImmuneResponse.by_experiment(@search)

        get :index

        @immune_responses.count.should == 0
      end
    end

    describe "with search by strain_name" do
      it "finds only immune responses with matching strain_name" do
        @search = ImmuneResponse.last.strain_name
        @immune_responses = ImmuneResponse.by_strain(@search)

        get :index

        @immune_responses.count.should > 0
        @immune_responses.each {|iresponse| iresponse.strain_name.should eq(@search)}
      end

      it "should only show records that are part of the group" do
        @search = ImmuneResponse.last.strain_name
        @immune_responses = ImmuneResponse.by_experiment(@search)

        get :index
        group_check
      end


      it "finds not find any macrophages without matching strain_name" do
        @search = "9999999999999"
        @immune_responses = ImmuneResponse.by_strain(@search)

        get :index

        @immune_responses.count.should == 0
      end
    end
  end

  # SHOW TESTS ---------------------------------------------------------

  describe "GET show" do
    before(:each){ @immune_response = ImmuneResponse.last }

    it "assigns the requested immune_response as @immune_response" do
      get :show, {id: @immune_response.to_param}
      assigns(:immune_response).should eq(@immune_response)
    end
  end

  # NEW TESTS ----------------------------------------------------------

  describe "GET new" do
    it "assigns a new immune_response as @immune_response" do
      get :new
      assigns(:immune_response).should be_a_new(ImmuneResponse)
    end

    it "should return success" do
      get :new
      response.should be_success
    end
  end

  # EDIT TESTS ---------------------------------------------------------

  describe "GET edit" do
    before(:each){ @immune_response = ImmuneResponse.last }

    it "assigns the requested immune_response as @immune_response" do
      get :edit, {id: @immune_response.to_param}
      assigns(:immune_response).should eq(@immune_response)
    end

    it "should return success" do
      get :edit, {id: @immune_response.to_param}
      response.should be_success
    end
  end

  # CREATE TESTS -------------------------------------------------------

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ImmuneResponse" do
        expect {
          post :create, {:immune_response => valid_attributes}, valid_session
        }.to change(ImmuneResponse, :count).by(1)
      end

      it "assigns a newly created immune_response as @immune_response" do
        post :create, {:immune_response => valid_attributes}, valid_session
        assigns(:immune_response).should be_a(ImmuneResponse)
        assigns(:immune_response).should be_persisted
      end

      it "redirects to the created immune_response" do
        post :create, {:immune_response => valid_attributes}, valid_session
        response.should redirect_to(ImmuneResponse.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved immune_response as @immune_response" do
        # Trigger the behavior that occurs when invalid params are submitted
        ImmuneResponse.any_instance.stub(:save).and_return(false)
        post :create, {:immune_response => { "experiment_id" => "invalid value" }}, valid_session
        assigns(:immune_response).should be_a_new(ImmuneResponse)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ImmuneResponse.any_instance.stub(:save).and_return(false)
        post :create, {:immune_response => { "experiment_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested immune_response" do
        immune_response = ImmuneResponse.create! valid_attributes
        # Assuming there are no other immune_responses in the database, this
        # specifies that the ImmuneResponse created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ImmuneResponse.any_instance.should_receive(:update).with({ "experiment_id" => "" })
        put :update, {:id => immune_response.to_param, :immune_response => { "experiment_id" => "" }}, valid_session
      end

      it "assigns the requested immune_response as @immune_response" do
        immune_response = ImmuneResponse.create! valid_attributes
        put :update, {:id => immune_response.to_param, :immune_response => valid_attributes}, valid_session
        assigns(:immune_response).should eq(immune_response)
      end

      it "redirects to the immune_response" do
        immune_response = ImmuneResponse.create! valid_attributes
        put :update, {:id => immune_response.to_param, :immune_response => valid_attributes}, valid_session
        response.should redirect_to(immune_response)
      end
    end

    describe "with invalid params" do
      it "assigns the immune_response as @immune_response" do
        immune_response = ImmuneResponse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ImmuneResponse.any_instance.stub(:save).and_return(false)
        put :update, {:id => immune_response.to_param, :immune_response => { "experiment_id" => "invalid value" }}, valid_session
        assigns(:immune_response).should eq(immune_response)
      end

      it "re-renders the 'edit' template" do
        immune_response = ImmuneResponse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ImmuneResponse.any_instance.stub(:save).and_return(false)
        put :update, {:id => immune_response.to_param, :immune_response => { "experiment_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested immune_response" do
      immune_response = ImmuneResponse.create! valid_attributes
      expect {
        delete :destroy, {:id => immune_response.to_param}, valid_session
      }.to change(ImmuneResponse, :count).by(-1)
    end

    it "redirects to the immune_responses list" do
      immune_response = ImmuneResponse.create! valid_attributes
      delete :destroy, {:id => immune_response.to_param}, valid_session
      response.should redirect_to(immune_responses_url)
    end
  end

end
