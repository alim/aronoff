########################################################################
# Scoped step defiinition for Immune Response feature and scenarios
########################################################################
steps_for :immune_responses do

  step "there is/are :count immune response(s)" do |count|
    count.to_i.times.each { FactoryGirl.create(:immune_response, user: @user) }
    @iresponses = ImmuneResponse.all
    @iresponses.count.should eq(count.to_i)
  end

  step "I/you click on immune responses link" do
    click_on 'Immune Res.'
    expect(page).to have_content 'Immune Response Results'
  end

  step "I/you should see :count immune response results" do |count|
    page.should have_css("table tr.immune_response", count: count.to_i)
  end

  step "enter a search by experiment ID" do
    @immune_response = @iresponses.last
    fill_in 'search', with: "#{@immune_response.experiment_id[0..3]}"
    select('Experiment', from: 'stype')
    click_button 'Search'

    # Calculate how many records we should find
    @count = ImmuneResponse.by_experiment(@immune_response.experiment_id[0..3]).count
    @count.should > 0
    @count = ApplicationController::PAGE_COUNT if @count > ApplicationController::PAGE_COUNT
  end


  step "enter a search by strain name" do
    @immune_response = @iresponses.last
    fill_in 'search', with: "#{@immune_response.strain_name[0..2]}"
    select('Strain', from: 'stype')
    click_button 'Search'

    # Calculate how many records we should find
    @count = ImmuneResponse.by_strain(@immune_response.strain_name[0..2]).count
    @count.should > 0
    @count = ApplicationController::PAGE_COUNT if @count > ApplicationController::PAGE_COUNT
  end

  step "you should see one or more immune response records" do
    page.should have_css("table tr.immune_response", count: @count)
  end

  step "you click on a single immune response entry" do
    @immune_response = ImmuneResponse.find_with_groups(@user).order_by(
          [[:experiment_id, :asc]]).first
    click_on "#{@immune_response.experiment_id}"
  end

  step "you should see an immune reponse record" do
    page.should have_content("#{@immune_response.experiment_id}")
    page.should have_content("#{@immune_response.strain_name}")
    page.should have_content("#{@immune_response.user.first_name}")
    page.should have_content("#{@immune_response.cell_type_str}")
    page.should have_content("#{@immune_response.model_str}")
    page.should have_content("#{@immune_response.compartment_str}")
    page.should have_content("#{@immune_response.time_point}")
    page.should have_content("#{@immune_response.moi}")
    page.should have_content("#{@immune_response.strain_status_str}")
    page.should have_content("#{@immune_response.treatment_str}")
    page.should have_content("#{@immune_response.result}")
    page.should have_content("#{@immune_response.cyto_chemo_kine_str}")
    page.should have_content("#{@immune_response.units_str}")
    page.should have_content("#{@immune_response.notes}")
  end

  step "I/you click on the :button_name button" do |button_name|
    click_on "#{button_name}"
  end

  step "I/you should see a :form_title form" do |title|
    page.should have_content("#{title}")
  end
end
