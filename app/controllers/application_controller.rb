class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :layout_by_resource

	######################################################################
	# A Devise method override that redirects the user to the admin_url
	# after they have signed into the system.
	######################################################################
	def after_sign_in_path_for(resource)
		admin_url
	end
	
	######################################################################
	# A Devise method override that redirects the user to the home_url
	# after they have signed out the system.
	######################################################################
	def after_sign_out_path_for(resource)
		root_url
	end	

  protected

	######################################################################
	# Callback function to specify the layout based on the controller that
	# is in use.
	######################################################################
  def layout_by_resource
    if self.is_a?(AdminController)
    	"admin"
    elsif self.is_a?(DeviseController)
			"devise"
    else
      "home"
    end
  end
end
