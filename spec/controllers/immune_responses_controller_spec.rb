require 'spec_helper'

describe ImmuneResponsesController do
  include_context 'immune_response_setup'

  # Test setup ---------------------------------------------------------

  let(:tags){'tag1,tag2,tag3,tag4,tag5'}
  let(:file) {
    fixture_file_upload('spec/fixtures/test_doc.pdf', 'application/pdf')
  }

  let(:valid_attributes){
    {
      experiment_id: 'Experiment-1234',
      strain_name: 'GBS-1234',
      cell_type: ImmuneResponse::DM_TERM,
      model: ImmuneResponse::CD_PUNCHES,
      compartment: ImmuneResponse::AMNION,
      time_point: '1 hr.',
      moi: '1234',
      strain_status: ImmuneResponse::HEAT_KILLED,
      treatment: ImmuneResponse::PGE2,
      dose: 'normal',
      result: '1234',
      cyto_chemo_kine: ImmuneResponse::TNFA,
      units: ImmuneResponse::UG_ML,
      notes: 'Sample notes for testing',
      tags: tags.split,
      raw_datafile: file
    }
  }

  before(:each) {
    immune_responses_project
    sign_in @owner
  }

  after(:each) {
    User.destroy_all
    Project.destroy_all
    ImmuneResponse.destroy_all
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
          post :create, {immune_response: valid_attributes}
        }.to change(ImmuneResponse, :count).by(1)
      end

      it "assigns a newly created immune_response as @immune_response" do
        post :create, {immune_response: valid_attributes}
        assigns(:immune_response).should be_a(ImmuneResponse)
        assigns(:immune_response).should be_persisted
      end

      it "redirects to the created immune_response" do
        post :create, {immune_response: valid_attributes}
        response.should redirect_to(assigns(:immune_response))
      end

      it "assigns the correct tags" do
        post :create, {immune_response: valid_attributes}
        assigns(:immune_response).tags.should eq(tags.split(','))
      end

      it "assings both existing and new tags" do
        tag_list = tags + ',tag99,tag100'
        post :create, {immune_response: valid_attributes, new_tags: 'tag99,tag100'}
        assigns(:immune_response).tags.should eq(tag_list.split(','))
      end
    end

    describe "with invalid params" do
      before(:each){
        @invalid_params = valid_attributes
        @invalid_params[:treatment] = 99999
      }

      it "assigns a newly created but unsaved immune_response as @immune_response" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {immune_response: @invalid_params}
        assigns(:immune_response).should be_a_new(ImmuneResponse)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {immune_response: @invalid_params}
        response.should render_template("new")
      end

      it "set validation error array" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {immune_response: @invalid_params}
        assigns(:verrors).should_not be_empty
        assigns(:verrors)[0].should match(/Treatment/)
      end
    end

    describe "file upload examples" do
      it "should allow attaching a pdf file" do
        post :create, immune_response: valid_attributes
        response.should redirect_to(assigns(:immune_response))
      end

      it "should upload file and set file name attribute" do
        post :create, immune_response: valid_attributes
        assigns(:immune_response).raw_datafile_file_name.should match(/test_doc.pdf/)
      end

      it "should upload file and set file url attribute" do
        post :create, immune_response: valid_attributes
        assigns(:immune_response).raw_datafile.url.should match(/test_doc.pdf/)
      end

      it "should upload file and set file content_type attribute" do
        post :create, immune_response: valid_attributes
        assigns(:immune_response).raw_datafile_content_type.should match(/pdf/)
      end
    end
  end

  ## UPDATE TESTS ------------------------------------------------------

  describe "PUT update" do
    before(:each){ @immune_response = ImmuneResponse.last }

    describe "with valid params" do
      it "updates the requested immune_response" do
        ImmuneResponse.any_instance.should_receive(:update).with({
          "experiment_id" => "Invalid Exp. ID 1111" })
        put :update, {id: @immune_response.to_param, immune_response:
          { "experiment_id" => "Invalid Exp. ID 1111" }}
      end

      it "assigns the requested immune_response as @immune_response" do
        put :update, {id: @immune_response.to_param,
          immune_response: valid_attributes}
        assigns(:immune_response).should eq(@immune_response)
      end

      it "redirects to the immune_response" do
        put :update, {id: @immune_response.to_param, immune_response:
          valid_attributes}
        response.should redirect_to(@immune_response)
      end
    end

    describe "with invalid params" do

      it "assigns the immune_response as @immune_response" do
        # Trigger the behavior that occurs when invalid params are submitted
        ImmuneResponse.any_instance.stub(:save).and_return(false)
        put :update, {id: @immune_response.to_param, immune_response:
          { "experiment_id" => "invalid value" }}
        assigns(:immune_response).should eq(@immune_response)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ImmuneResponse.any_instance.stub(:save).and_return(false)
        put :update, {id: @immune_response.to_param, immune_response:
          { "experiment_id" => "invalid value" }}
        response.should render_template("edit")
      end
    end

    describe "file upload examples" do
      it "should allow attaching a pdf file" do
        put :update, {id: @immune_response.to_param, immune_response: { raw_datafile: file }}
        response.should redirect_to(assigns(:immune_response))
      end

      it "should upload file and set file name attribute" do
        put :update, {id: @immune_response.to_param, immune_response: { raw_datafile: file }}
        assigns(:immune_response).raw_datafile_file_name.should match(/test_doc.pdf/)
      end

      it "should upload file and set file url attribute" do
        put :update, {id: @immune_response.to_param, immune_response: { raw_datafile: file }}
        assigns(:immune_response).raw_datafile.url.should match(/test_doc.pdf/)
      end

      it "should upload file and set file content_type attribute" do
        put :update, {id: @immune_response.to_param, immune_response: { raw_datafile: file }}
        assigns(:immune_response).raw_datafile_content_type.should match(/pdf/)
      end
    end
  end

  ## DELETE TESTS ------------------------------------------------------

  describe "DELETE destroy" do
    before(:each){ @immune_response = ImmuneResponse.last }

    it "destroys the requested immune_response" do
      expect {
        delete :destroy, {id: @immune_response.to_param}
      }.to change(ImmuneResponse, :count).by(-1)
    end

    it "redirects to the immune_responses list" do
      delete :destroy, {id: @immune_response.to_param}
      response.should redirect_to(immune_responses_url)
    end

    it "should NOT destroy related user or project" do
      user_count = User.count
      project_count = Project.count
      user = @immune_response.user
      project = @immune_response.project

      delete :destroy, {id: @immune_response.to_param}

      User.count.should eq(user_count)
      user.should be_present
      Project.count.should eq(project_count)
      project.should be_present
    end
  end

end
