########################################################################
# Global or shared step definitions that are used by more than one
# feature test.
########################################################################

#
# Login as a standard user
#
step "a user is logged in" do
  @user = FactoryGirl.create(:user)

  # Login to the application
  visit new_user_session_path
  within("#new_user") do
    fill_in 'Email', :with => "#{@user.email}"
    fill_in 'Password', :with => 'somepassword'
  end
  click_button 'Login'
  expect(page).to have_content 'Dashboard'
end

step "I/you click on the :link_name link" do |link_name|
  click_link link_name
end

step "I/you should see :search_text on the page" do |text|
  page.should have_content(text)
end
