class ImmuneResponsesController < ApplicationController
  before_action :set_immune_response, only: [:show, :edit, :update, :destroy]

  # GET /immune_responses
  # GET /immune_responses.json
  def index
    @immune_responses = ImmuneResponse.all
  end

  # GET /immune_responses/1
  # GET /immune_responses/1.json
  def show
  end

  # GET /immune_responses/new
  def new
    @immune_response = ImmuneResponse.new
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
