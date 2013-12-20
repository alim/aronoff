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
    @search_options = [
      ['Experiment', 'experiment'],
      ['Strain', 'strain'],
      # ['ImmuneResponse', 'ImmuneResponse'],
    ]

    # Get page number
    page = params[:page].nil? ? 1 : params[:page]

    @immune_responses = ImmuneResponse.all

    # Check to see if we want to search for a subset of users
    if params[:search].present? && params[:stype].present?
      @search = params[:search]
      @stype = params[:stype]

      case @stype
      when 'experiment'
         @immune_responses = ImmuneResponse.find_with_groups(current_user).by_experiment(@search).paginate(page: page, per_page: PAGE_COUNT)
      when 'strain'
        @immune_responses = ImmuneResponse.find_with_groups(current_user).by_strain(@search).paginate(page: page,  per_page: PAGE_COUNT)
      # when 'ImmuneResponse'
      else
        @immune_responses = ImmuneResponse.find_with_groups(current_user).order_by(
          [[:experiment_id, :asc]]).paginate(page: page,  per_page: PAGE_COUNT)
      end
    else
      @immune_responses = ImmuneResponse.find_with_groups(current_user).order_by(
        [[:experiment_id, :asc]]).paginate(page: page,  per_page: PAGE_COUNT)
    end
  end

  # GET /immune_responses/1
  # GET /immune_responses/1.json
  def show
  end

  # GET /immune_responses/new
  def new
    @immune_response = ImmuneResponse.new
    @projects = Project.where(user_id: current_user)
  end

  # GET /immune_responses/1/edit
  def edit
  end

  # POST /immune_responses
  # POST /immune_responses.json
  def create
    @immune_response = ImmuneResponse.new(immune_response_params)

    respond_to do |format|
      if @immune_response.save
        format.html { redirect_to @immune_response, notice: 'Immune response was successfully created.' }
        format.json { render action: 'show', status: :created, location: @immune_response }
      else
        format.html { render action: 'new' }
        format.json { render json: @immune_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /immune_responses/1
  # PATCH/PUT /immune_responses/1.json
  def update
    respond_to do |format|
      if @immune_response.update(immune_response_params)
        format.html { redirect_to @immune_response, notice: 'Immune response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @immune_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /immune_responses/1
  # DELETE /immune_responses/1.json
  def destroy
    @immune_response.destroy
    respond_to do |format|
      format.html { redirect_to immune_responses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_immune_response
      @immune_response = ImmuneResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def immune_response_params
      params.require(:immune_response).permit(:experiment_id, :strain_name, :cell_type, :model, :compartment, :time_point, :moi, :strain_status, :treatment, :units)
    end
end
