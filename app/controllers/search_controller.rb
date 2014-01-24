#######################################################################
# The SearchController centralizes all global search functions that
# search for records across both the ImmuneResponse and Macrophage
# data sets.
#######################################################################
class SearchController < ApplicationController

  ## Callback declarations --------------------------------------------
  rescue_from Mongoid::Errors::DocumentNotFound, with: :missing_document
  rescue_from CanCan::AccessDenied, with: :access_denied

  before_action :set_search_class

  #####################################################################
  # 
  #####################################################################
  def index
  end

  #####################################################################
  # The bacteria method presents the user with a search form for 
  # querying the database. The search form enables the user to search
  # for experimental results by bacteria name.
  #####################################################################
  def bacteria
    @search_bacteria_active="class=active"
  end
    
  #####################################################################
  # The by_bacteria method will search both the Macrophage and 
  # ImmuneResponse data by bacterial strain_name for matching result
  # records. This method also support downloading of results via
  # CSV file format.
  #####################################################################
  def by_bacteria
    @strain_name = params[:strain_name]

    # Get page number
    page = params[:page].nil? ? 1 : params[:page]

    if @strain_name.present?
      @immune_responses = ImmuneResponse.find_with_groups(
        current_user).by_strain(@strain_name).paginate(
        page: page, per_page: PAGE_COUNT)
      @macrophages = Macrophage.find_with_groups(
        current_user).by_strain(@strain_name).paginate(
        page: page, per_page: PAGE_COUNT)
    else
      flash[:alert] = "No bacterial strain name was selected"
    end

    respond_to do |format|
      format.html

      if params[:macrophages]
        format.csv { send_data @macrophages.to_csv, 
          filename: "#{@strain_name}-macrophages" }
      else
        format.csv { send_data @immune_responses.to_csv,
          filename: "#{@strain_name}-immune-responses" }
      end

    end

  end

  def user
    @search_user_active="class=active"
  end

  def by_user
  end

  def date
    @search_date_active="class=active"    
  end

  def by_date
  end

  ## PRIVATE INSTANCE METHODS -----------------------------------------

  ######################################################################
  # The set_group_class method sets an instance variable for the CSS
  # class that will highlight the menu item. 
  ######################################################################
  def set_search_class
    @search_active = "class=active" 
  end
end
