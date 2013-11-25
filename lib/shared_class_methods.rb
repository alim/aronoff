########################################################################
# The SharedMethods module is used for storing methods that will be 
# accross multiple Rails model classes. To use these methods, you will
# need to:
#   
#    extend SharedMethods
#    
# in your model class definition
########################################################################
module SharedClassMethods
  	
  ######################################################################
	# The find_with_groups class scope method will return all resource
	# records that have a group in common with the User that is passed
	# in as a parameter.
	######################################################################
	def find_with_groups(user)

		begin
			# Find all group ids associated with User
			groups = User.find(user.id).groups

			if groups.present?	
		
				# For each group associated with the user find the resource ID's
				# of the ones they own
				ids = []
				ids = user.send(self.to_s.underscore.pluralize).pluck(:id)
				
				groups.each {|group| ids += group.send(self.to_s.underscore.pluralize).pluck(:id)}
				ids.uniq!
				ids.sort!

				where(id: ids)
			else
				where(user_id: user.id)
			end
		rescue  ActiveRecord::RecordNotFound
			logger.error("[#{self}.find_with_groups] Could not find user - user ID: #{user.id}")
			scoped
		end
	end	
end
