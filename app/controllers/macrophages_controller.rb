class MacrophagesController < ApplicationController
  
  ## RESCUE SETTINGS ---------------------------------------------------
  
	rescue_from Mongoid::Errors::DocumentNotFound, with: :missing_document
  rescue_from CanCan::AccessDenied, with: :access_denied
  
  ## CALLBACKS ---------------------------------------------------------

  before_action :set_macrophage, only: [:show, :edit, :update, :destroy]
  before_action :set_macrophage_class
  
  # GET /macrophages
  # GET /macrophages.json
  def index
    @macrophages = Macrophage.all
  end

  # GET /macrophages/1
  # GET /macrophages/1.json
  def show
  end

  # GET /macrophages/new
  def new
    @macrophage = Macrophage.new
  end

  # GET /macrophages/1/edit
  def edit
  end

  # POST /macrophages
  # POST /macrophages.json
  def create
    @macrophage = Macrophage.new(macrophage_params)

    respond_to do |format|
      if @macrophage.save
        format.html { redirect_to @macrophage, notice: 'Macrophage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @macrophage }
      else
        format.html { render action: 'new' }
        format.json { render json: @macrophage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /macrophages/1
  # PATCH/PUT /macrophages/1.json
  def update
    respond_to do |format|
      if @macrophage.update(macrophage_params)
        format.html { redirect_to @macrophage, notice: 'Macrophage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @macrophage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /macrophages/1
  # DELETE /macrophages/1.json
  def destroy
    @macrophage.destroy
    respond_to do |format|
      format.html { redirect_to macrophages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_macrophage
      @macrophage = Macrophage.find(params[:id])
    end
    
    def set_macrophage_class
      @macrophage_active = "class=active"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def macrophage_params
      params.require(:macrophage).permit(:strain_name, :experiment_id, :macrophage_type, :treatment, :dose, :data, :data_type)
    end
end
