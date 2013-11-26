# Provide shared macros for testing user accounts
shared_context 'macrophage_setup' do
  include_context 'group_setup'
  
	# Multiple macrophage objects
	let(:macrophages) {
    user = FactoryGirl.create(:user)
    user.save
	  5.times.each { FactoryGirl.create(:macrophage, user: user) }
	}
  
  # Multiple macrophage objects associated with a project and single
  # group with multiple users
  let(:macrophage_project) {
    single_group_with_users
    @user = User.first
    @group = Group.first
    
    # Add a project to the group
    @project = FactoryGirl.create(:project, user: @user)    
    @group.projects << @project
    
    # Create macrophages associated with a project
    5.times.each { FactoryGirl.create(:macrophage, user: @user, project: @project) }
  }
  
  # Multiple macrophage objects associated with two projects and
  # two groups
  
  
end
