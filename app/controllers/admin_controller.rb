class AdminController < ApplicationController
	before_filter :authenticate_user!
	
	layout 'admin' 

	######################################################################
	# The index action presents the dashboard or main landing page after
	# logging into the service.
	######################################################################
	def index
		@admin_active="class=active"

		@immune_responses = ImmuneResponse.find_with_groups(current_user).order_by([[:created_at, :asc]])
		@ir_count = @immune_responses.count <= 10 ? @immune_responses.count : 10
		@immune_responses = @immune_responses[0..@ir_count] if @ir_count > 0

		@macrophages = Macrophage.find_with_groups(current_user).order_by([[:created_at, :asc]])
		@mac_count = @macrophages.count <= 10 ? @macrophages.count : 10
		@macrophages = @macrophages[0..@mac_count] if @mac_count > 0

  end

	######################################################################
	# Error action and view to display errors to the user.
	######################################################################
	def oops
	end

	######################################################################
	# Password_reset presents the password reset page.
	######################################################################
	def password_reset
		@password_reset_admin_active="active"
	end

	######################################################################
	# The help function will present a help page for the service.
	######################################################################
	def help
		@help_admin_active = "class=active"
	end    
	
end
