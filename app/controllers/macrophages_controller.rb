########################################################################
# The MacrophagesController class is responsible for managing the views
# and data interactions for the Macrophage experimental results.
########################################################################
class MacrophagesController < ApplicationController

  ## RESCUE SETTINGS ---------------------------------------------------

  rescue_from Mongoid::Errors::DocumentNotFound, with: :missing_document
  rescue_from CanCan::AccessDenied, with: :access_denied

  ## CALLBACKS ---------------------------------------------------------
  before_filter :authenticate_user!
  before_action :set_macrophage, only: [:show, :edit, :update, :destroy]
  before_action :set_macrophage_class

  ######################################################################
  # GET /macrophages
  # GET /macrophages.json
  #
  # The index method provides the ability to view all the macrophage
  # results that are permitted to be viewed by the user. We allow the
  # user to search for a subset by experiment id or strain_name. The
  # results will also be paginated. Finally, we allow downloading of
  # the experimental results into CSV file.
  ######################################################################
  def index

    # Get page number
    page = params[:page].nil? ? 1 : params[:page]

    # Check to see if we want to search for a subset of users
    if params[:search].present? && params[:stype].present?
      @search = params[:search]
      @stype = params[:stype]

      case @stype
      when 'experiment'
        if request.format.csv?
          @macrophages = Macrophage.find_with_groups(current_user).by_experiment(@search)
        else
          @macrophages = Macrophage.find_with_groups(current_user).by_experiment(
            @search).paginate(page: page, per_page: PAGE_COUNT)
        end

      when 'strain'
        if request.format.csv?
          @macrophages = Macrophage.find_with_groups(current_user).by_strain(@search)
        else
          @macrophages = Macrophage.find_with_groups(current_user).by_strain(
            @search).paginate(page: page,  per_page: PAGE_COUNT)
        end

      else
        if request.format.csv?
          @macrophages = Macrophage.find_with_groups(current_user).order_by(
          [[:experiment_id, :asc]])
        else
          @macrophages = Macrophage.find_with_groups(current_user).order_by(
            [[:experiment_id, :asc]]).paginate(page: page,  per_page: PAGE_COUNT)
        end

      end

    else
      if request.format.csv?
        @macrophages = Macrophage.find_with_groups(current_user).order_by(
        [[:experiment_id, :asc]])
      else
        @macrophages = Macrophage.find_with_groups(current_user).order_by(
          [[:experiment_id, :asc]]).paginate(page: page,  per_page: PAGE_COUNT)
      end

    end

    respond_to do |format|
      format.html
      format.csv { send_data @macrophages.to_csv }
    end
  end

  ######################################################################
  # GET /macrophages/1
  # GET /macrophages/1.json
  #
  # Standard show method. We use model helper methods for displaying
  # the human readable strings for some of the attributes.
  ######################################################################
  def show
  end

  ######################################################################
  # GET /macrophages/new
  #
  # Standard new method with attributes for showing projects and strains
  ######################################################################
  def new
    @macrophage = Macrophage.new
    @projects = Project.find_with_groups(current_user)
    @tag_list = Macrophage.tags
  end

  ######################################################################
  # GET /macrophages/1/edit
  #
  # The edit method presents the edit form and loads the requested
  # Macrophage record. It also loads a list of user accessible projects
  # that can be associated with the Macrophage record.
  ######################################################################
  def edit
    @projects = Project.find_with_groups(current_user)
    @strains = get_strain_list
    @tag_list = Macrophage.tags
  end

  ######################################################################
  # POST /macrophages
  # POST /macrophages.json
  #
  # The create method creates a new macrophage record and sets the
  # user/owner to the currently signed in user.
  ######################################################################
  def create
    @macrophage = Macrophage.new(macrophage_params)
    @macrophage.user = current_user if @macrophage.user.nil?
    @macrophage.tags = process_tags(params[:macrophage][:tags], 
      params[:new_tags])

    respond_to do |format|
      if @macrophage.save
        format.html { redirect_to @macrophage, notice: 'Macrophage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @macrophage }
      else
        @verrors = @macrophage.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @macrophage.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # PATCH/PUT /macrophages/1
  # PATCH/PUT /macrophages/1.json
  ######################################################################
  def update
    @macrophage.user = current_user if @macrophage.user.nil?
    @macrophage.tags = process_tags(params[:macrophage][:tags], 
      params[:new_tags])
    
    respond_to do |format|
      if @macrophage.update(macrophage_params)
        format.html { redirect_to @macrophage, notice: 'Macrophage was successfully updated.' }
        format.json { head :no_content }
      else
        @verrors = @macrophage.errors.full_messages
        format.html { render action: 'edit' }
        format.json { render json: @macrophage.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # DELETE /macrophages/1
  # DELETE /macrophages/1.json
  ######################################################################
  def destroy
    @macrophage.destroy
    respond_to do |format|
      format.html { redirect_to macrophages_url }
      format.json { head :no_content }
    end
  end

  ## PRIVATE INSTANCE METHODS ------------------------------------------

  private

    ####################################################################
    # Use callbacks to share common setup or constraints between actions.
    ####################################################################
    def set_macrophage
      @macrophage = Macrophage.find(params[:id])
    end

    ####################################################################
    # The set_macrophage_class method sets a CSS class variable for
    # views that need to activate/highlight a menu item.
    ####################################################################
    def set_macrophage_class
      @macrophage_active = "class=active"
    end

    ####################################################################
    # Never trust parameters from the scary internet, only allow the white list through.
    ####################################################################
    def macrophage_params
      params.require(:macrophage).permit(:strain_name, :experiment_id,
        :macrophage_type, :treatment, :dose, :data, :data_type, :notes,
        :raw_datafile, :project_id)
    end

    ####################################################################
    # The get_strain_list method is responsible for pulling a list
    # of GBS strains from the MLST system.
    ####################################################################
    def get_strain_list
      # Implmentation needed
    end

end
