########################################################################
# Scoped step defiinition for Immune Response feature and scenarios
########################################################################
steps_for :search_steps do

  step "there are :count records with matching bacteria name" do |count|
    @strain_name = 'GB1007'

    count.to_i.times.each { FactoryGirl.create(:bacteria_immune_response, 
      user: @user, strain_name: @strain_name) }
    @iresponses = ImmuneResponse.all
    @iresponses.count.should eq(count.to_i)

    # Calculate how many records we should find
    @ir_count = ImmuneResponse.by_strain(@strain_name).count
    @ir_count.should > 0
    @ir_count = ApplicationController::PAGE_COUNT if @ir_count > ApplicationController::PAGE_COUNT

    count.to_i.times.each { FactoryGirl.create(:bacteria_macrophage, 
      user: @user, strain_name: @strain_name) }
    @macrophages = Macrophage.all
    @macrophages.count.should eq(count.to_i)

    # Calculate how many records we should find
    @mac_count = Macrophage.by_strain(@strain_name).count
    @mac_count.should > 0
    @mac_count = ApplicationController::PAGE_COUNT if @mac_count > ApplicationController::PAGE_COUNT  
  end
  
  step "you search for records matching bacteria name" do
    select('GB1007', from:'strain_name')
    click_button('Search')
  end

  step "you should see correct number of result records" do
    page.should have_css("table tr.immune_response", count: @ir_count)
    page.should have_css("table tr.macrophage", count: @ir_count)
  end

  step "you click on Export CSV for :type" do |type|
    if type == 'macrophages'
      click_link('export_macrophage_csv')
    elsif type == 'immune responses'
      click_link('export_immune_response_csv')
    else
      puts "Unable to find the correct type to export to CSV"
    end
  end

  step "I/you should get a file named :name" do |name|
    page.driver.response.headers['Content-Disposition'].should include("filename=\"#{name}\"")
  end
end
