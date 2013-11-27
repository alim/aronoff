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
    @owner = User.find(@group.owner_id)

    # Add a project to the group
    @project = FactoryGirl.create(:project, user: @user)
    @group.projects << @project

    # Create macrophages associated with a project
    5.times.each { FactoryGirl.create(:macrophage, user: @user, project: @project) }
  }

  # Multiple macrophage objects associated with two projects and
  # two groups
  let(:macrophage_project_groups) {
    multi_groups_multi_users
    @group_one = Group.first

    # Create project with same owner as a group
    @project_one = FactoryGirl.create(:project, user: @owner)
    @project_one.groups << @group_one

    # Create macrophages associated with a project
    5.times.each { @project_one.macrophages << FactoryGirl.create(:macrophage, user: @owner, project: @project_one) }

    # Create second group and project
    @group_two = Group.last
    @project_two = FactoryGirl.create(:project, user: @owner)
    @project_two.groups << @group_two

    5.times.each { @project_two.macrophages << FactoryGirl.create(:macrophage, user: @owner, project: @project_two) }
  }

end
