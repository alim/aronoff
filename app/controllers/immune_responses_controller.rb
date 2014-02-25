########################################################################
# The ImmuneResponsesController is responsible for managing the
# functions associated with interacting with the ImmuneResponse model
# class. The ImmuneReponse class is designed to hold immune response
# experimental results. The controller provides interacts with the
# views to allow searching, editing, creating, and deleting of the
# immune response result records.
########################################################################
class ImmuneResponsesController < ApplicationController

  ## RESCUE SETTINGS ---------------------------------------------------

  rescue_from Mongoid::Errors::DocumentNotFound, with: :missing_document
  rescue_from CanCan::AccessDenied, with: :access_denied

  ## CALLBACKS ---------------------------------------------------------
  before_filter :authenticate_user!
  before_action :set_immune_response, only: [:show, :edit, :update, :destroy]

  ######################################################################
  # GET /immune_responses
  # GET /immune_responses.json
  #
  # The index method enables users to list all the available immune
  # response results visible to their account. It also enables basic
  # searching of the response results by experiment ID and by
  # bacterial strain name.
  ######################################################################
  def index
    # Get page number
    page = params[:page].nil? ? 1 : params[:page]

    @immune_responses = ImmuneResponse.all

    # Check to see if we want to search for a subset of users
    if params[:search].present? && params[:stype].present?
      @search = params[:search]
      @stype = params[:stype]

      case @stype
      when 'experiment'
        if request.format.csv?
          @immune_responses = ImmuneResponse.find_with_groups(
            current_user).by_experiment(@search)
        else
          @immune_responses = ImmuneResponse.find_with_groups(
            current_user).by_experiment(@search).paginate(
            page: page, per_page: PAGE_COUNT)
        end

      when 'strain'
        if request.format.csv?
          @immune_responses = ImmuneResponse.find_with_groups(
            current_user).by_strain(@search)
        else
          @immune_responses = ImmuneResponse.find_with_groups(
            current_user).by_strain(@search).paginate(page: page,
            per_page: PAGE_COUNT)
        end

      # when 'ImmuneResponse'
      else
        if request.format.csv?
          @immune_responses = ImmuneResponse.find_with_groups(
            current_user).order_by([[:experiment_id, :asc]])
        else
          @immune_responses = ImmuneResponse.find_with_groups(
            current_user).order_by([[:experiment_id, :asc]]).paginate(
            page: page,  per_page: PAGE_COUNT)
        end

      end
    else
      if request.format.csv?
        @immune_responses = ImmuneResponse.find_with_groups(
          current_user).order_by([[:experiment_id, :asc]])
      else
        @immune_responses = ImmuneResponse.find_with_groups(
          current_user).order_by([[:experiment_id, :asc]]).paginate(
          page: page,  per_page: PAGE_COUNT)
      end
    end

    respond_to do |format|
      format.html
      format.csv { send_data @immune_responses.to_csv }
    end
  end

  ######################################################################
  # GET /immune_responses/1
  # GET /immune_responses/1.json
  #
  # The show method shows the ImmuneRespnose attributes, including a
  # link to the original data file.
  ######################################################################
  def show
  end


  ######################################################################
  # GET /immune_responses/new
  #
  # The new method presents a new ImmuneResponse results form, which
  # also includes the ability to associate the result record with one
  # of the projects that are accessible by the current project.
  ######################################################################
  def new
    @immune_response = ImmuneResponse.new
    @projects = Project.find_with_groups(current_user)
    @tag_list = ImmuneResponse.tags
  end

  ######################################################################
  # GET /immune_responses/1/edit
  #
  # The edit method presents the edit form for the ImmuneResponse
  # result record. It also includes the ability to associate the
  # result record with one of the projects that are accessible by
  # the current project.
  ######################################################################
  def edit
    @projects = Project.find_with_groups(current_user)
    @tag_list = ImmuneResponse.tags
  end

  ######################################################################
  # POST /immune_responses
  # POST /immune_responses.json
  #
  # The create method will generate a new ImmuneResponse model object
  # to store the result attributes and relates the record to the
  # project record.
  ######################################################################
  def create
    @immune_response = ImmuneResponse.new(immune_response_params)
    @immune_response.user = current_user if @immune_response.user.nil?
    @immune_response.tags = process_tags(params[:immune_response][:tags], 
      params[:new_tag])

    respond_to do |format|
      if @immune_response.save
        format.html { redirect_to @immune_response, notice: 'Immune response was successfully created.' }
        format.json { render action: 'show', status: :created, location: @immune_response }
      else
        @verrors = @immune_response.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @immune_response.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # PATCH/PUT /immune_responses/1
  # PATCH/PUT /immune_responses/1.json
  #
  # The update method will update an existing ImmuneResponse model object
  # to store the result attributes and relates the record to the
  # project record.
  ######################################################################
  def update
    @immune_response.user = current_user if @immune_response.user.nil?
    @immune_response.tags = process_tags(params[:immune_response][:tags], 
      params[:new_tag])

    respond_to do |format|
      if @immune_response.update(immune_response_params)
        format.html { redirect_to @immune_response, notice: 'Immune response was successfully updated.' }
        format.json { head :no_content }
      else
        @verrors = @immune_response.errors.full_messages
        format.html { render action: 'edit' }
        format.json { render json: @immune_response.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # DELETE /immune_responses/1
  # DELETE /immune_responses/1.json
  #
  # The delete method will destroy the specified ImmuneResponse method.
  ######################################################################
  def destroy
    @immune_response.destroy
    respond_to do |format|
      format.html { redirect_to immune_responses_url }
      format.json { head :no_content }
    end
  end

  ## PRIVATE INSTANCE METHODS ------------------------------------------

  private

    ####################################################################
    # Use callbacks to share common setup or constraints between actions.
    ####################################################################
    def set_immune_response
      @immune_response = ImmuneResponse.find(params[:id])
    end

    ####################################################################
    # Never trust parameters from the scary internet, only allow the white list through.
    ####################################################################
    def immune_response_params
      params.require(:immune_response).permit(:experiment_id,
        :strain_name, :cell_type, :model, :compartment,
        :time_point, :moi, :strain_status, :treatment,
        :result, :units, :cyto_chemo_kine, :tags)
    end
end
